Return-Path: <linux-kernel+bounces-807786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35764B4A93B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802CC1BC53E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500A82DD5F6;
	Tue,  9 Sep 2025 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=miraclelinux-com.20230601.gappssmtp.com header.i=@miraclelinux-com.20230601.gappssmtp.com header.b="DIMN1JAs"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD5E2C2349
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411914; cv=none; b=QAabo7IUsSBfl7CUFVZ+Li8sCmZPgMgQ1nbs2GbYO0B1LfhqWDCSNRu9BdgJGoTdGpgCRTVh8jK02pYHVw4D7pwqQp6t5E7/ETg0QvZbHGJqHC3Gvhn7FRT4w/XluMHRi16MbnH6wTZaoVG759UhaVBeLR2qsk3PmpKusxnCCrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411914; c=relaxed/simple;
	bh=BcPTgT4DaoNK+sqLNjn9V4T8XzfeAlyDj3xfj5ssbQ8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aZEmEvBiwYxO/fZigjldst8FRBA7+G+L2npsf0rdOcaQY50QH9H4mKevSmjyjTxF04jaXImhB+A7qNVVPrPMHt4CLHrlBOGRVwTBxNIRl65qY4QDZJpqS8kVXNP368/DCwOrbyNafAiSzY1W3QXtP4gG5LP2AMRXceOBsUrGHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com; spf=pass smtp.mailfrom=miraclelinux.com; dkim=pass (2048-bit key) header.d=miraclelinux-com.20230601.gappssmtp.com header.i=@miraclelinux-com.20230601.gappssmtp.com header.b=DIMN1JAs; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraclelinux.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32b5d8bea85so3668901a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1757411908; x=1758016708; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BcPTgT4DaoNK+sqLNjn9V4T8XzfeAlyDj3xfj5ssbQ8=;
        b=DIMN1JAse1U/j1fqbaao3izdr1gD41+chyV1F124LiQ6zQr7Nv2KC3iRbcqu4QWe7I
         N+saklMxd1CMGoQSHZ2sQJBouHRtdx3FJQHGmHO+2mxfwSFcGJ63faVug9QC5MnRncWA
         ulRQeC+8334W9eFoxX41HUbLwHdrz8dpsmMvsohpTz9/xEkV2o0VXHr1VJ4XeTQ+DwpA
         30GYOujz6tlACU5BK1bmt+UkpN49UmnU0IBHBV4BOEcYu3iwL8mQWMAp7hnfFMOhAccY
         fhOc8UvG4cQDVdDpr2cs6oFv/3RmmupMf7zAklRgZl6faNpVpMZZrYq4eQp5K9kFn1hP
         J8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757411908; x=1758016708;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcPTgT4DaoNK+sqLNjn9V4T8XzfeAlyDj3xfj5ssbQ8=;
        b=wHfvFQID7BOgasLG4bOpJF5xLHLkhjV+q/xF9GGrIqHrEKEzvi+3Nrflo6XZgoKlNJ
         ulfqThU+LszS41FJZ1WEKbCVFTfvIClKDKeYCAEaeeqZl39qJNtw7SkLnYf2ES8id+Ha
         rsxWloRSFykmKoc/9P6wN4F2A2nnC1FQj47Efnl9SUA9b5wsN7uLpfEgZf80lbdMFnjj
         XcXiik9EE2BbEZTqxnryYg6eRfs+mNR/eI14rL0PtZtbeV1sSmPH6ENMOMUyFIbjn86Q
         IFZ/vn8q/yJh3fYTDPR+RMHmXCXSOBfQlnT22UNSMRzTnEOY3WdodBTE7vvew7Z+76on
         e8FA==
X-Forwarded-Encrypted: i=1; AJvYcCW+4kb8QrbYURE28MZ00QK7xkDEuGYpcheiFew3tEhRu7Nhqdb4n/H+L8swgzHwhaXINVb815XREywYUvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcPPxlZGMRpKYX9vK/xgRgHdwCfu1TdZ7p1keLZRb0UaolkjJY
	wB87t1WSxPl2xwAKQKJ3PwJr68vLnLkFRLXs5poB9EzJsnwzjzx7ztX2gcmts1S4rP1D4001N/T
	n35bN3JKzlsEpIFkKb4U7EwqlzIBdGFDYpy7NKBgA
X-Gm-Gg: ASbGnct29xvDiUjhxTDs3JZiWskIZyZ/p22Da6/58fQpTJckbAOmCv6Y/tK4lr5NNwU
	x4peOtGPq7G3dgg035/km4an4TvjFgfZlakMM/0JwaqqUuk/K4L4Dk62a+S3qbWpglro/3C344L
	efQANG4A8hrkpyjR5Hn2Z1BoFeS2MpWmvodtzkKHn+I66rHGUDfKWoSN/arzUk/2LBpMsfE5pb+
	XvB7tg=
X-Google-Smtp-Source: AGHT+IF1m2rO1lq8YsNb1JZtLnx7YFPnA47qj42l6x17TNVIDAy2/K7vf752ZAqr693wrJ0dJTpLhqHDZ0QSSmGW6t8=
X-Received: by 2002:a17:90b:2c8f:b0:327:53f0:6368 with SMTP id
 98e67ed59e1d1-32d45037a0emr11618836a91.2.1757411907905; Tue, 09 Sep 2025
 02:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Tue, 9 Sep 2025 18:57:51 +0900
X-Gm-Features: Ac12FXxcZ5tawe6vldEzR473P71-6XB_eXqZ2l7lI71wYP_rV2SpmrFPdLf5NAs
Message-ID: <CANgtXuMNY0KfdSJuHZh2khaGtNr8ic3hNGPkEG4mKw3p7YOhZg@mail.gmail.com>
Subject: [ANNOUNCE/CFP] Kernel Testing & Dependability Micro-conference at LPC
 Japan 2025 CFP postponed until 30th September
To: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shuah@kernel.org, gtucker@gtucker.io, sashal@kernel.org, 
	kernelci@lists.linux.dev, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

The Call For Proposal (CFP) for the Kernel Testing & Dependability
Micro-Conference at Linux Plumbers 2025 has been updated.
https://lpc.events/event/19/contributions/2001/

You still have time until the 30th September for sending your CFP:
https://lpc.events/event/19/abstracts/

Thanks,
Arisu & Guillaume & Shuah & Sasha

