Return-Path: <linux-kernel+bounces-725871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4202B004DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BBD488359
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E0E271456;
	Thu, 10 Jul 2025 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="m7JlWAkn"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60E26E6FE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156803; cv=none; b=sRAm/rcXYHf9Shdo9x0s94QCRQMgYYh1rd0Ehf7oGWGFyLpLc0LFpocWeq+unCPBIc/9r8Xxudtk8cSks2ssomTn0bJryEHYWH92dlvVsIUJpQINQ7xUnD/DH0+ZDrYmpaiYmgCsd75iJ8/Q2nyVfh08xMIcdUVIvo+UcR5Dz1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156803; c=relaxed/simple;
	bh=m3jJP4tcnyBOZ/ODiD/dI+4CH6ZhaVWKBUwJ2va5Hpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aqf17Q/crwOVtn75r67n4uMOP3Wfu1h3HW4e3CrIW++0CwRok0vZ2U8vA3yCihv4tYuqO53hepkG2eIo1kA0Jx4Mrghjpsdzg+RcG8mjOsR4zBrfzASphi2ZaLMoJ942qMC5ul3P5eFiudgJQ5TjFvjB0lkioC1KmQvKV6K15KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=m7JlWAkn; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fd0a91ae98so6674686d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752156801; x=1752761601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4D8h7/0g6nmmKvt9dKEaFtHgB5fxkN8z+u5enhCJdIQ=;
        b=m7JlWAknaGo0wmwgKgW4efJBZT+/e/VqUQaLImZPrTd8YUOvF5Pm8J1IEjgWuiMGjr
         FOXXo4PzVjhwpUZ2JbODYuAeOYGdmmaPmnvIdk+wi9SQOxS50civES8+5ojIiymz3jB8
         FUq2BFyvbIjcJF7T5fWjh00WNvN0qI7NAhCuSQWRIS2/fSAjipBu8N9nZBIsYS1ON0AS
         I3IsUMmb2Ktv7au6s3ZQKR6kvtr3QZxOTS6vz3c9GctryYMfqLYSADLAYLwiVIcnrR1d
         MHdbNAP3UHi4XUud6Pjj0njEGLfDu/P4L+NVpNFzGchozxkgckS5kIsv81WZGiLWaGh4
         9JRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752156801; x=1752761601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D8h7/0g6nmmKvt9dKEaFtHgB5fxkN8z+u5enhCJdIQ=;
        b=h0XzTMY498PdWVg1RQxff6VXkrb9ROu0NFVphcqHWsOBjV3m3ymJBO4Py9Lkazwr4E
         u34YXKqHZAR6SutKbqkPEqx+QJqSywIkhbWH2PBE0VxH8LHUHVTaBz2ofrIqTIOzG4Jb
         41+sR8r7KkxVzb4PY5C3QXiVa1sZkbgj50n4mrPVmnQ+BqGpnp9Z1Vz7RHg2XxgCvJA8
         iNSxHow8gkvdjYj56H+DBe/ko/PuPwjymfeD3QxQ7KqBg0y7fo8BFYL96npfepaLqMLp
         BK3z7Yom2dYr0E5WhFPAs8HR0sjaIrWtYdrimKnMm9teDQS3tTSOjMrxpP6FNRRdbC90
         UNjw==
X-Forwarded-Encrypted: i=1; AJvYcCXJv9B0fi2SRhMFNMqJ165/n8q09+Fopvwfp3BOdiL12ZlDFCS7i+vaM/c/sG73wKN5+wWrwXpKq3wrpSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN1AVk+6PHOWUiACrZGAuYWKArhCNRmY7Lky4fCmiDN9085IZt
	lX4qJTpNGMNEiQG/Cwqzn+gtA0DcvAmvO75Kpc3iF0W53cL41nv6IdP673gZZ7C9Eg==
X-Gm-Gg: ASbGncscUdcjoueMRuu4ADcbMxVMVLUsLX1/t+JmjPcj6ttRhRJyxErm4KyM1Z6eK9F
	nouBRzzo5v+tmpgMb7xHO/s5oJJZuANZarK7qspWEPQzbJbxK3/QjSn7LfixFmbOXBGtwVSKH+b
	LP/2KFZeqFfYXX1jGXEdGQO7MAXGAumXNS8hZLkgpPktwEd+F0WAU9twZ9Ba92gim7OqnOT9fRY
	R/5VjnF+jy7a5PjBeOCah6QWIISMidbiSlabMKha4x8oWpv7ljWxBTwoY/jqyrfVvPJuDKzZUGL
	1iwNLR7Joa5YOf/+FvxYPx9mUj71SvQgPFs+OqijxsaH1qnwaxro3tiUYef4m1Ud871QfGgJxWG
	7rl31dYtwcSYqy88=
X-Google-Smtp-Source: AGHT+IHoXSW8SI/r5MX7aKZkdWUiZt8QqOcECvdbr80PUX2wz0dTv3Xj53RBdvKykmXs3qFGbGb50Q==
X-Received: by 2002:a05:6214:450e:b0:704:8ce6:bda2 with SMTP id 6a1803df08f44-7049801dafemr48034246d6.14.1752156800537;
        Thu, 10 Jul 2025 07:13:20 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e459csm8813196d6.49.2025.07.10.07.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:13:20 -0700 (PDT)
Date: Thu, 10 Jul 2025 10:13:18 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	USB list <linux-usb@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
Message-ID: <b12dd926-2f81-4feb-a3b0-b7fca2592909@rowland.harvard.edu>
References: <686e7698.050a0220.c28f5.0006.GAE@google.com>
 <79f634db-c149-4220-b8d4-0fff2c6b6a01@I-love.SAKURA.ne.jp>
 <e064a3e4-ae70-4a24-ba5e-1bb8c7971f23@rowland.harvard.edu>
 <39f312fa-d461-4377-b809-50c8a7188f6b@I-love.SAKURA.ne.jp>
 <dd932df4-2a13-4a5c-a531-376065f87391@rowland.harvard.edu>
 <43189e93-2cad-429a-a604-15bf5cc95e43@I-love.SAKURA.ne.jp>
 <1d471e25-6671-4cb2-a2c9-af96c2b4e13d@rowland.harvard.edu>
 <a8bed564-3eec-472d-8e57-aaf5274c13b1@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8bed564-3eec-472d-8e57-aaf5274c13b1@I-love.SAKURA.ne.jp>

On Thu, Jul 10, 2025 at 07:17:19PM +0900, Tetsuo Handa wrote:
> On 2025/07/10 0:41, Alan Stern wrote:
> > Okay, I see what your problem is.
> > 
> > The bEndpointAddress field of the endpoint descriptor is not just the 
> > endpoint's number.  It also includes the endpoint's direction in bit 7 
> > (0 for OUT, 1 for IN).
> 
> I see, but I couldn't figure out whether BUG_ON(endpoint > 0xF) is bad.
> 
> I came up to try these BUG_ON() lines in case some of hung task reports (e.g.
> https://lkml.kernel.org/r/686e8032.050a0220.385921.0006.GAE@google.com ) are
> caused by use of unintended pipes created by out-of-range values being passed
> to __create_pipe().

I think this is unlikely to be the cause of those BUG_ON()s, but go 
ahead and see what happens.

> Should I give up BUG_ON(endpoint > 0xF) line?
> Or should I try to update callers which trigger BUG_ON(endpoint > 0xF) line?

You can change the test to BUG_ON(endpoint & ~0x8F).  That will mask 
away the endpoint number and direction bit, leaving everything else 
alone.

Alan Stern

