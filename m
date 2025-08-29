Return-Path: <linux-kernel+bounces-791258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B47B3B40E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5F117A03E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81883262808;
	Fri, 29 Aug 2025 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RoWQDuK6"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9321CA0C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451685; cv=none; b=QZHOkcceQwmXj3KMx9RCJcPnciC0JYYPJd0BZ22Hsh3L+xQpBkjfdGPDS27ng5cHVXQeQzGoHIZr001/daETZhFTmY1b9JLeV9nxxxuyfDM8gL/smQhLP6LCII1TDbx6+NYeA2hvBoncx9EHjLf2J2ZYi08gQxMf2W/Nd/8CA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451685; c=relaxed/simple;
	bh=qHKGWPBebBo4zhj4/R+6T8g4Wu6cLAiinMsKHxNt3so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YflJXzGArRfjBOH09GHCXuZXK++aVTHHJ19oaDar2+0WLaOmJdrbFtTLEvb2a6pRfeMCX2+MFwTvRK7LT1lI9zqBRNagr5ZEAW0E35nXDt738/g5j8DJvgNUg4j3W5F7sR0b//CJwbAjWzD18j2CuoZmAjUBua6WtvDuLA2qhOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RoWQDuK6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c79f0a5fe0so1025955f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756451682; x=1757056482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnAIYKYIPy93nPHNmWiB7bO5LeKcaSAfNJLovkkHCL4=;
        b=RoWQDuK6kQUs+vEnV7MzxK158KmS2NqSbv8UzjTvlXRTAIPVjmWBWApvo7a4N5eLGN
         U04w8qqar4iMcZNfInGhjkZLgImi8LI+XlMN1ficaogwsX99OS7CWtBKVziDc8K6AdTO
         ZbTbdhxWtPgfLRFIyc0Vfqdz/K5TlzA7ezzxmNugAkUJ1XIr4Kqb8vhZoek1zoQtmPSo
         iKF0jXFt1M5r8hxThpD1MqTk/O6FpBDmyGIF9H6m5UoCmMNMILXdZi7lTTYbkK5lJb2Q
         rg4Qa1rl4yQtbrtFLeRGcjot1RH0gN+VF7xQewtUS68STQpfgn9VjzyQRVVmwWZuOINn
         dkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756451682; x=1757056482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnAIYKYIPy93nPHNmWiB7bO5LeKcaSAfNJLovkkHCL4=;
        b=qLWxeWiEpgddNXkU4sjfR9Si7r5yqD+pLFnOR0wGBJ/AFamDNPDY1zWtfX53UoCiFn
         ss3cCyH4edp/KwGa08Jr+khK8u06O/tAxC5cHo+WBT2MpJM4HcyEyk3zR4fnk+h5n0NP
         I4tKd+WdPMOYeAO7lpmyjfpflN5VMFn4/O/mrOaNyxPltSN/Fn3E69epVxVLoSA9E5oI
         3we7ebmVk0Gsq0dn/Khujm5RkuI9QdO9/e8lfBj4srTtJzPYyb7PVtvpzynMt7fx6Ily
         d1F64tM/ajn1BEncfk0gHyQefOYgrqslNlnLzWAAdMIBk6jm0AUCLBK93gxhKVlkNAFz
         46aw==
X-Forwarded-Encrypted: i=1; AJvYcCUjlrMpXcvJ1xtVy0UeAoZnR6XIuqGCW56fv6EO6jyXoLwBcrLmo+0Zw3aWCvlbSfZQ3wZMeP+frKzByGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRxAqVI0jdx8E9pNb3XOTFP6irQEUWJE2OupVWgJsC2EZicyS
	3OdcqG9WTW16Iw3eHmi6YomQaqksVXcIyBm4QFy7zJAMsxT1/lTohs1aNqsllTdaV/E=
X-Gm-Gg: ASbGncsnDZ7Pt/F33EaeeCDSRKNNq8WilIOw1gMSAy6RPYGrpY9Rq74RxLYh6TAZx3L
	Ff5k4UBSl10PzKLelqQyFnJfYOucG7o5LDex7ReiSp4/aOSVweOKesrdBJmKqdU8FFI+Y9WeDv2
	sNY2sgs3yOOUWSjhe80ZgjBJMKFSxHpZC3XhepfVzeoFwG97sOsDjz1R5W+rpIFOPD1Qa9pJRyr
	LS0mhMGcylWhdoIho1hfnkWVl9WHjKTU410tSg1taaSozMsQasx/PoDEEnS2Ts9vN8zOeHrK1yr
	wQJF7aHmsd0XVR8FA6OzgAh2O4y+9D5SqTbb8jBCHHjj1MUi3/gfpTzLILYPnMk0O+XjQKNmIfk
	YC+hUb0fq6H0kGycNedUKOn+2a23BqKSVA1g=
X-Google-Smtp-Source: AGHT+IET92ZW4pB+PBFF6uzPVIkMqG7CO0rfrkoigRQ4KbVW1FPAcvtd1uJYjG2e8Me+yGBpksIpVQ==
X-Received: by 2002:a05:6000:1182:b0:3cd:1cc2:f411 with SMTP id ffacd0b85a97d-3cd1cc2ff1amr4896530f8f.61.1756451681755;
        Fri, 29 Aug 2025 00:14:41 -0700 (PDT)
Received: from localhost (109-81-86-254.rct.o2.cz. [109.81.86.254])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e7d23b7sm25531145e9.1.2025.08.29.00.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:14:41 -0700 (PDT)
Date: Fri, 29 Aug 2025 09:14:40 +0200
From: Michal Hocko <mhocko@suse.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: zhongjinji <zhongjinji@honor.com>, rientjes@google.com,
	shakeel.butt@linux.dev, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, liam.howlett@oracle.com, liulu.liu@honor.com,
	feng.han@honor.com
Subject: Re: [PATCH v5 2/2] mm/oom_kill: Have the OOM reaper and exit_mmap()
 traverse the maple tree in opposite order
Message-ID: <aLFTYG9ciypqjTwT@tiehlicka>
References: <20250825133855.30229-1-zhongjinji@honor.com>
 <20250825133855.30229-3-zhongjinji@honor.com>
 <002da86b-4be7-41a1-bb14-0853297c2828@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002da86b-4be7-41a1-bb14-0853297c2828@lucifer.local>

On Tue 26-08-25 13:53:43, Lorenzo Stoakes wrote:
> On Mon, Aug 25, 2025 at 09:38:55PM +0800, zhongjinji wrote:
> > When a process is OOM killed without reaper delay, the oom reaper and the
> > exit_mmap() thread likely run simultaneously. They traverse the vma's maple
> > tree along the same path and may easily unmap the same vma, causing them to
> > compete for the pte spinlock.
> >
> > When a process exits, exit_mmap() traverses the vma's maple tree from low
> > to high addresses. To reduce the chance of unmapping the same vma
> > simultaneously, the OOM reaper should traverse the vma's tree from high to
> > low address.
> >
> > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> 
> I will leave it to Liam to confirm the maple tree bit is ok, but I guess
> I'm softening to the idea of doing this - because it should have no impact
> on most users, so even if it's some rare edge case that triggers the
> situation, then it's worth doing it in reverse just to help you guys out :)

I tend to agree on this. I would expect that oom_reaper would race with
exit_mmap only for seriously stalled processes or huge memory consumers
where exit_mmap takes a while. oom_reaper would be quick to catch the
exit_mmap as it wouldn't have fewer work to do on already released
memory.
Going from the other end of the address space might reduces this chance
while not really introducing any actual issues.

-- 
Michal Hocko
SUSE Labs

