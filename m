Return-Path: <linux-kernel+bounces-891699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F529C43460
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 21:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C48B44E16CB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 20:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54018244660;
	Sat,  8 Nov 2025 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="uXCbx/Ve"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1716A22422A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762632142; cv=none; b=MgKXTjqrar1GKrMW62ByJM9g6dN2EYq9BPTwT/FMUeBZJek+nbRb70Mz/1/vxZFUkRaa9DLw+Vx+Bn4HjpICLN0sbquPo9+miwLws/A1EIn+3H+HO+kM5X7eH3CO+SLpYELph9o9nkNfe4012Yr4NEtFhjIgCrnU4wYj6BcQes0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762632142; c=relaxed/simple;
	bh=vEZrLeBeJ7h1ipH89PqPi/zSNBxuNbQgKGCtCvuVOvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWjwKYnM+7IqPizLZHzLvUrHBSj7u8Ba+mrCoXbom2mJyeZZD2L5MNmmgu72wQHhwMpJ1YoQpl7vqaQdQBcOX7d91qrf+2dXo7x8vtzcvV0R13LRAj11VdWdcybVn6Lt9xARJUpaygwZ2i5OOOZ5F22BUYpEbAOClYraXuGLSXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=uXCbx/Ve; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2148ca40eso273720085a.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 12:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1762632140; x=1763236940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=afLIDtjU2jTYgwYOZlnNOt8tUMpTLcQFNlRa10jsVq4=;
        b=uXCbx/Ve2EP0neuZFLhGWMy7dXysEzjXrFPt9Cfj2/6+/JfLqnyirWi5b5PuhpFSP8
         txe5vj8WXnF4+p8ytuMPVWFJ4EPZiVxjNZoW7FKnA7rs3L5fntgkK/JBAK+s9TMGREes
         zsmyoT+OJC99bEsm8ArDdqfWNOb8ZsDqphUMDJsSc/27OTJRmXAzKUuaIaR6LCg0hPpa
         ECFUwdASC9W9yFA1Q8bqaAv1KJMHSus6yMUC9axWzxNBcTJ0OukccjH+elO7M0I05Fh7
         GRUqJkwfl2a/xfbD6Bpbu9R5wOh27yVuxG25Eypz809YlhWNLCLX1by7+KLTS9XoiPSp
         b+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632140; x=1763236940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afLIDtjU2jTYgwYOZlnNOt8tUMpTLcQFNlRa10jsVq4=;
        b=lZLG7KnxJQYFArga8LtzYXtM58l04jwiFOWxoK8GFJx2pTU0c8p0W4na27ryRNwnOW
         +ctNsAJDokUVbVEnIDdUVVTfLtW0ex0aYmfYC9X+zJaXAvHWtzKhh/2sHaJSnXf1PBti
         eus4S5QkuZSrO2VHYdTyqyOC7iBBjCB3fSJTMTEIDCOpD5RId1gLbrPEzOEZeeDBnLlP
         255JM8A9tYxeizSh7b7F3t22hASCcBSnA1pzRUBYyrlQYRwbb5LlPC6Cr0pZCNiNrSYS
         0MNSLQ5fayYG1JyCHE8ehpF9sNoidbh8ChY9ZpJ5vEpw8N2O3IJWMvze7IwzTpbw/R63
         La2w==
X-Gm-Message-State: AOJu0Yx2TtGIyUXaqabbZvtWErdX3LvX8ccnQksdgnBIM96+m4CfhJkN
	22OGDe3homs/2TJliyCKp0NgLyCEqe1AuLSoAC03NTz9sDYNpAWdgt+UHfK0A5usWshWyyPKElj
	KlBc4
X-Gm-Gg: ASbGncvTKfEdXplrq1Jj8gX/nWOmmRPTSTX0+KwixXASgrHAOFV8B7jZH9DHgOsydpF
	bScBMCCMQE8aQuChWIskybH1zgjpbN9gNOTeaf8MPWHmUKyE5ToQWXJR21aL2OytDqHl2b6D5ro
	N+Z330o1644br6gjJgpPSJgTh1HrGicSWPUS7bJLCOgG91UTUF871WKbUbqUE2h158h7jdIyloa
	VVRmEDxLep0r7QYkWypAnD5xzMdFwOfVZen/UK+BKWlcFxO1Xmai9ev4rGQuzg9dTkcaFawrgQg
	IFgHHtcX4P60kfbTCnOcdSEVw5+7Hf91lBFMasseICtqXTxM37NdQ8gP+Lozzito41PXmstEktq
	p9+2TtCdQXZy8N3DrVHzOodNAbhsaaIFVre0LgWTOOtGkKlg47eATiJ+ObE3cdgnFYsEXkS1F/h
	Oj39/l9AC8w3atFnavdbcEiaSsy77qxA==
X-Google-Smtp-Source: AGHT+IEP6njqvP7OJ8++MLrTcCjSZ1Kt6Z5ev6k1eTY7/VIni/FZ+4NbLV9Nf5JbGDhmp9iwi4d50A==
X-Received: by 2002:a05:620a:701b:b0:8a2:319d:27c3 with SMTP id af79cd13be357-8b257f683a0mr386978485a.73.1762632140037;
        Sat, 08 Nov 2025 12:02:20 -0800 (PST)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-8b2355e9a35sm659818685a.20.2025.11.08.12.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:02:18 -0800 (PST)
Date: Sat, 8 Nov 2025 15:02:17 -0500
From: Nick Bowler <nbowler@draconx.ca>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: PROBLEM: boot hang on Indy R4400SC (regression)
Message-ID: <j5uutbx2oi2ccudo54o4hgxfmwfchwmd2ktig6xjgkqa7ho2pj@xb4luighppnc>
References: <g3scb7mfjbsohdszieqkappslj6m7qu3ou766nckt2remg3ide@izgvehzcdbsu>
 <e4ed75c7-b108-437f-b44b-69a9b340c085@app.fastmail.com>
 <ea6p4efuwbrlqjiwkgjcd7ofj7aahfnnvnkooo2il36ggzrlcj@n6mcofpb2jep>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea6p4efuwbrlqjiwkgjcd7ofj7aahfnnvnkooo2il36ggzrlcj@n6mcofpb2jep>

On Fri, Nov 07, 2025 at 03:12:31PM -0500, Nick Bowler wrote:
> On Fri, Nov 07, 2025 at 07:29:25PM +0000, Jiaxun Yang wrote:
> > Unfortunately my Indy won't go over ARCS prom so I'm not in a position
> > to debug this on my side. I have inspected the code again and I can't
> > see anything preventing it to work on R4000 family.
> 
> I'll try adding some extra prints to at least figure out where it is
> actually hanging.

I did not have much success with adding prints, but looking more closely
at the console output it seems that what is ultimately failing is the
SCSI bus enumeration which does not complete unless I revert commit
35ad7e181541.

So I presume that is why I also don't see the messages about mounting
the root filesystem (I suppose it is just waiting for a disk).

I see the drivers printing the usual info about each device, but not
everything.  Specifically, the lines that are missing are all of these
ones that would normally be printed:

    sda: sda1 sda2 sda9 sda11
   sd 0:0:1:0: [sda] Attached SCSI disk

    sdb: sdb1 sdb9 sdb11
   sd 0:0:2:0: [sdb] Attached SCSI disk

   sr 0:0:5:0: Attached scsi CD-ROM sr0

Other than that everything else seems alive.  Several other drivers
go through their initialization during the time the SCSI stuff is not
completing.  The 'random: crng init done' message is printed after a
while too.

I tried enabling CONFIG_SOFTLOCKUP_DETECTOR and CONFIG_WQ_WATCHDOG to
get some more information out but these options do not seem to do
anything in this scenario, nothing is printed even after ~10 minutes.

Thanks,
  Nick

