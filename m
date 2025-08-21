Return-Path: <linux-kernel+bounces-780428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB45B301C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28240600C04
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C6434321D;
	Thu, 21 Aug 2025 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qz5FnDJp"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05904C6E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799998; cv=none; b=oXY/e2OU7f7ywSHkAwLlZoxGFwD4DSuRTyyeNX5qj0IpJ0By3n6WuMKtFlGhrqaWJx1EWTAxo+HWHVW0wvcsd0AB3dyeFpe6/opzMRXkYZx/t85lE4huMWnxlkThioljFTUzMwxxzpTQ2xgthcy9DG79DTqafzjtxi9TRMaoAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799998; c=relaxed/simple;
	bh=S/0MnwIt1MK5ntVRZqUW3RFW1+f/AVRFM0vmditzRf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q25Alfn9n6C/Dlmpj8zsWdK6qevMLo8I5T1/ujqxiLCueYW5RDbh0yVaYedEmXd1P9eL9giDDp9bEi33vFjYrlmwFQAqEpnL7I6Pr8Ngx58gEUZR5c5OySW2x9cIA8IZDSHEEsP1pTf83jlnji2kL4G1XH0gNOe6IM1F+nJtBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qz5FnDJp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b098f43so9638565e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755799994; x=1756404794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BGw2gz83VnqWh3iPZPi/VoJGrAOor0mQelqsKrCx7Fw=;
        b=Qz5FnDJpIXcJvlMHxixDDps7+neA7BT/ETPLJjhtqWnuLyK1Q2Mq3pmVPYTNjAzopO
         Kji+CQ1/QBc3WRP5dGpCxBlRpLbUNs5T3tK5XRhYwxHmKfHRPUNcjNR6q3Qk38N7yTT+
         4f71iTrfRxmlLR5YTdFaEziQ1ICML3sf1iqoy6esv9jeDiqaiBLf7L9TYCvwTzBhJMDI
         LdMj2XBE84n3EAFKnkyEtqJb//LE0YYSHgJ8AC3UHK0OIOVson7+wxl8hFUFg1iT14iC
         LxprI7RYYhhL4nDPFQHiTu5We97NxzsQ+9Hs9vfrhfqp2mSsG2I8zuw748NPJjG9xuU4
         ow5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755799994; x=1756404794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGw2gz83VnqWh3iPZPi/VoJGrAOor0mQelqsKrCx7Fw=;
        b=FIUXZXOhcVaWtbsGtecldKHHhVaekVbQ9WoMbqxMr4IJRN5m2utxBQ8WJpuwetuAr1
         JmW0c7VHXHcOHT/cMeGAcKIOr4QAgqb4x+uNMt/eNW45klv6VexEhizgyDweDpczQzbK
         D9AvvJcht+hIBLpEQd4yI4ruq5HeyBl3o/0sGPkZreid2ujixVoobhD+1Qcw8ZvUG6Zl
         YVI4lAnX3NtvSBQR1Zz9U6r4dN5/OWHleZ0BWYx3tJPFn+c+K7o2h2hMqX7novCnVu+N
         08x+yJDNKgVCO7yn6L8oCgqspsPS6rJTIl/jsdcNEtVWHdj1gU2a3XGVHjIwhJq6TkZ5
         JnxA==
X-Forwarded-Encrypted: i=1; AJvYcCUKF5cw0kwNMOm/romHJVXMytlKmpk+ZDtVL2vCxB3b2bjmYElUSyauHGZMKw2fnnTWI1l0uW2ZkCwZPhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoc+LUH0fPdC/792Nd8CYrKHV0Nk0Yi78I1wv63rryJasNs96P
	gdeKXMbrP+yfq32sOI7UpJDLTl7zAQB4leNxA2LTcydKRW6oU2UzBVtuzKVKfHnyi0k=
X-Gm-Gg: ASbGncsL2n9egA7NoqTkIBRQ7Y2AqEsLyQBs+wzb+cvvZX7A89Zf8lT9GJiqlUujL9x
	olDpNhSV2H1TGKMJaIxsIJshapR5vl+lvZsb31YePAc0VkcCkqEpJ275y1EoIQnjmpfnglwfDFj
	+My6iqP59rPHMZjTc+oIftHBK6Wn07DfXpx5PP41EWYE8C5US5kllw7CsgNijiWwsTcwEdnjBxt
	0jjxTVxJZ+Dz3lv2XzmHJfoWfIT8jNVocyNx+9vDgHEWK3+RW5EjQmpLoQOyKlmNac3bpqXhdr4
	QlH+XUWl37bwCH5H1p5BrsHBXZCjOgDLW2N1GDsHgd2D/62kvL0A4qqo2czIM2/GjikuJMZ5gUu
	+2H7AjbzmOy9M+0aOGOkY1g+usTDYLhpwyKc=
X-Google-Smtp-Source: AGHT+IHW94p0zXqbNrntrEKvEvPhwFJb/hMTXSneXVk+pvqJenqm2aWB58Y+dKNDOltzNdcF32bTxg==
X-Received: by 2002:a05:600c:3589:b0:458:a992:6f1e with SMTP id 5b1f17b1804b1-45b51799443mr734265e9.5.1755799993903;
        Thu, 21 Aug 2025 11:13:13 -0700 (PDT)
Received: from localhost (109-81-21-139.rct.o2.cz. [109.81.21.139])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e3a587sm6865795e9.18.2025.08.21.11.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:13:13 -0700 (PDT)
Date: Thu, 21 Aug 2025 20:13:12 +0200
From: Michal Hocko <mhocko@suse.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: zhongjinji <zhongjinji@honor.com>, akpm@linux-foundation.org,
	andrealmeid@igalia.com, dvhart@infradead.org, feng.han@honor.com,
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, liulu.liu@honor.com, mingo@redhat.com,
	npache@redhat.com, peterz@infradead.org, rientjes@google.com,
	shakeel.butt@linux.dev, tglx@linutronix.de
Subject: Re: [PATCH v4 2/3] mm/oom_kill: Only delay OOM reaper for processes
 using robust futexes
Message-ID: <aKdhuOMrwgdxE9It@tiehlicka>
References: <aKIvd4ZCdWUEpBT_@tiehlicka>
 <20250818120819.26709-1-zhongjinji@honor.com>
 <aKRWtjRhE_HgFlp2@tiehlicka>
 <20250820025308.rkqlvauh4dz42oic@offworld>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820025308.rkqlvauh4dz42oic@offworld>

On Tue 19-08-25 19:53:08, Davidlohr Bueso wrote:
> On Tue, 19 Aug 2025, Michal Hocko wrote:
> 
> > On Mon 18-08-25 20:08:19, zhongjinji wrote:
> > > If a process holding robust futexes gets frozen, robust futexes might be reaped before
> > > futex_cleanup() runs when an OOM occurs. I am not sure if this will actually happen.
> > 
> > Yes, and 2s delay will never rule that out. Especially for frozen tasks
> > which could be frozen undefinitely. That is not the point I have tried
> > to make. I was suggesting not treating futex specially because no matter
> > what we do this will always be racy and a hack to reduce the risk. We
> > simply cannot deal with that case more gracefully without a major
> > surgery to the futex implementation which is not desirable for this
> > specific reason.
> 
> Yeah, relying on time as a fix is never a good idea. I was going to suggest
> skipping the reaping for tasks with a robust list, 

let me reiterate that the purpose of the oom reaper is not an oom
killing process optimization. It is crucial to guarantee a forward
progress on the OOM situation by a) async memory reclaim of the oom
victim and b) unblocking oom selection to a different process after a)
is done. That means that the victim cannot block the oom situation for
ever. Therefore we cannot really avoid tasks with robust futex or any
other user processes without achieving b) at the same time.

The current delay is something we can tune and still have b) in place.
Normal mode of operation is that the oom reaper has nothing really to do
and that is really a good thing.

-- 
Michal Hocko
SUSE Labs

