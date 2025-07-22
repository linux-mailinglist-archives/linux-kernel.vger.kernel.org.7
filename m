Return-Path: <linux-kernel+bounces-741351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7809B0E31A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1618C3A2703
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364BB28031D;
	Tue, 22 Jul 2025 17:55:20 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9D9279DC4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206919; cv=none; b=TqgBIfB51lJtlNuNdaRJkG3wh4543MF9nfHetv7AKePU63Q/T94U6svfTgrmoIDNkgJ3H5h7AO06WRisvoPM1DJTRDjl+/MAWFu3g7pRvlHJPyvtaRgUUDUMgqUD0SCWNQowcquyW5W82hPGY4UtRuLCqVY9bN/NqDm0kFGNB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206919; c=relaxed/simple;
	bh=+JUCvse9/Q0h83pSfOVoqRwPa3cwg92XlBECM4wBwMg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=i5WoiObaWzuk1ifkoAi+grwjlbxKgIV3UblTBIxEeu7yxyWqa3aCaOcSTcH4h2LshaI+WEmzHnMK8Hfb87kW3MfLhpeDSww85lipWLSrD2T+N2akGD7S7Uk0OFbIByL4sh8Qy3T3wx+RPJ5flWzqklhK/VzzUfT2bxVoH6Qa20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-879c1688420so16896739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753206917; x=1753811717;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+JUCvse9/Q0h83pSfOVoqRwPa3cwg92XlBECM4wBwMg=;
        b=GmDcZMklbvvtnhhF3T4lbtCQY+Sz7cdDOVI9f+2J4VMdf2bgWxpZ6VAkV3uVaa8lFM
         +1TOwM7PjH4wtwrEa9/YwJNZNg/BV3kPvt+wLf+QbL3fYb7jCHzQuJZaK4PpF0Cxrc1o
         3DgRtzCBUbiQH5Xq1YTyjJUi+zYbOeTehI2PmRWInJyiHrLz5hSU9e5QrsgHbFOqu3nk
         rtYnNDKx0fDiWA3tbjr4nBEww6HNr9TjLv6iSCM3Y2sL4aPhQ4Zivb41Vct1EMNfDNM2
         IBNVQLsS2WeFIp5zKa3XakU6kUYWka7dops/2m7CacdmoLTABInN1e1KDXx7dpJ/49wd
         xKEA==
X-Forwarded-Encrypted: i=1; AJvYcCW85UHly6Gw4llMfPD4nJtLBPFvvq1dvSsvpU6pov4CNC0uA1KZAD6xKNUh82HKvx+DbrRTkjB79dzt2GE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjGb/ELk5ZGayQR5PhA4AOsnvzq+5/Q17UpjWK84v1y1JaHLjw
	cTXt0tG16/m/HaxR9HkFROqLPAz2BfXMyGamdoAnspcMmw8mtx28xoAPdagCENr8qo5QDYAaJf9
	ZITEjGZfrlroIQSMnxpv62LeE2JWoDQ2hEBnBQBtsMSUVU95XoJg/euD1+XA=
X-Google-Smtp-Source: AGHT+IEnZCeH751BFdoEhmWWVC/2QU/u1JIWsR5UBGORLRUIn04iBieQDH4T7gcYQHSc9SnRnLic3XPmpo3B+yrD3wmrwVToKop5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4746:b0:876:b17c:dec3 with SMTP id
 ca18e2360f4ac-87c5389b0e8mr829314939f.8.1753206917538; Tue, 22 Jul 2025
 10:55:17 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:55:17 -0700
In-Reply-To: <xq4a62ukblverdhefpn3e43dkhaxvk2brdytqonrbzy3mud76m@srllmpvcv4e5>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687fd085.a70a0220.693ce.0107.GAE@google.com>
Subject: Re: [syzbot] [block?] [bcachefs?] kernel panic: KASAN: panic_on_warn
 set ...
From: syzbot <syzbot+4eb503ec2b8156835f24@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev
Cc: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

> On Sat, Apr 19, 2025 at 08:23:50AM -0400, Kent Overstreet wrote:
>> I'm not sure which subsystem this is, but it's definitely not bcachefs -
>> we don't use buffer heads.
>
> I think there's some incorrect deduplication going on with this bug,
> some of the reports do not look closely related, I believe they're all
> buffer heads related.
>
> #syz set-subsystems: block fs

unknown command "set-subsystems:"


