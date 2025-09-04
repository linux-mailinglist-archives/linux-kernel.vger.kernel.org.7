Return-Path: <linux-kernel+bounces-799753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF7B42FD6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C51C1BC741A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CC72040B6;
	Thu,  4 Sep 2025 02:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvZxTRsZ"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D61F8728
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953511; cv=none; b=BkcmfLmhMflMeFLJfAu6qIIk8E7/u7r96KOWEgC7D+ikex5ubKV7LrCRGOE9CASg/6AlF30iKPnKqgqHHKqk+PjJWPz+rCTqFjRF7wYQ2PrEXOIGrixjbY9VilLl7mmJzN97QJ3j1z4XoK0uEUyhkQ2at3QKCvp+KedLaYJzRHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953511; c=relaxed/simple;
	bh=gt/1ux9jF+HA7NGZH4b8I8x6guW0hIucfUmZRaX8Lnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILTM96QY5qRFRsfTSrZa/Z1+6q5L6QlvXkFNvnLRaXwfaP+AG627HRPwCBZGc7Z1VETSeyh/LVn5UnYXR9pTdvPT1cuim/MLN5jgMEXtdTd/I7UOhbusH/u7sHHDnlYH1GB/d4t8s8MZHvcQfvsIV9SeMsFChSesCe9ckT+GD/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvZxTRsZ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70ddadde494so4477616d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756953509; x=1757558309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt/1ux9jF+HA7NGZH4b8I8x6guW0hIucfUmZRaX8Lnw=;
        b=bvZxTRsZdCOr2+qszKEdW+grpHo4wzMuN5i5Ml5qDV5uhrrNyPSnkSM+alP0Big6Sf
         rojAC9iatd1O7JMMgJK1b7tsUWjqip3drsw3Hp24Nxx7QeGFpCCpOpgR31IQfHNWCRrm
         qKuNruV2KkQ1jxbTGnoKSwTv5+s9j0xa0uDkRJI0GcRCCCEM3Ms3SVI6Mikt2CMqGVVH
         bFEpPAbh+yml1AAlnSMZdHG3b30heXVH4h/mGs1rcJ+7b/+7zchZ1j3KLZOWAkSGA/7K
         f4WtqBOrx86imZLDgixzME+OVVIrPFiv+XJJbvo+wRf8p6pHKbJ4W7oCLxQpw6jnKA6F
         tN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756953509; x=1757558309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt/1ux9jF+HA7NGZH4b8I8x6guW0hIucfUmZRaX8Lnw=;
        b=MSPFhpmFONw7P07FBPPzkSPW+zoVDKWmwofXnxch9NIbT+g1+c7BW4oc33uLT1HxQk
         lkLC3qo+S1YlirMz+HeyrjYvkkOTExdTB/HRYeISRisiApuUYj4y5knhoalZZRHEUHGK
         TvqtlSepGojy94qzJ/oG/MWjYKQ9KeINUmCAvNTMsUdzfYmWGFSrCzU5qtWYOOM7F7Kg
         t3I8+K/hiLOf1cGz+fMRC1hipufD8EcwU55ACxIcmd5HjlZpb11rteM1gZyVmR9+xKq3
         AKrdudVV43BDRxkx4cwS8kRcysKH3D0w7EXntHUtIe3NEXAMNSyuXrOqrji0tWW5BT2M
         afuw==
X-Forwarded-Encrypted: i=1; AJvYcCUYbqMag2SvlGI1OIwWwChjQsBDqGt7Au2AJu/P++hrWD3mYEt+I0l79gMe1NtN8eJvRxmHDcgmO2Z6ErU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvxz53WLFYjOfmSvW5nvyEpskzjEOcPRhGc2x1gtMMoq42P5oQ
	wnCnV5T1HScs4pEpc5XFIxJVQV68dLjU7nwtavYDhjthdLjW4H+9HZcP
X-Gm-Gg: ASbGncuiFhye92zbANMX3zEMe4XjVVKJBpwIiCKHwyQEiEAduCznh2z5rh/BBqKlMNd
	y8V3JIYXGNzd1mzD8t0VTIC9vKjZGb1NQns4Cko5hd7o4ArRMXWNYlqxEpW2emjvtogU3+iFNgy
	WpiQJd5zAMY//nDzYsf9iszi255bH+K5pTGNGkqNBRQOiaNnn6MwkPIYGHydxn430g85ZJDrC70
	yAbKke7HrHuct5208n3bMuamlbnvSoxF6UgR17118d2JZz1mt6ecuWqe29PhMsPRTR7/PowQ8zE
	ixG26LwJjtnR+LoFQiSNyNCmS+0T9CtZLeldc/LA2zur9i0gjHW7KZs4ipgouioCHM5Fl1094NF
	SFYHpBzhSn+KvKkZeWHZfo5X6LYN69dTb0u+qGyMcUO//iq0TyKFG99YVGNpUnQ==
X-Google-Smtp-Source: AGHT+IEUP5RyMi1VOlfV+ceyjVn2nI/9lfMvjpM6uk2kMPvXZW8k4AHW6Lneo77FQNkYuZR/4O7Riw==
X-Received: by 2002:a05:6214:2629:b0:724:271a:9750 with SMTP id 6a1803df08f44-724271a9f49mr54076586d6.12.1756953509374;
        Wed, 03 Sep 2025 19:38:29 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720add668bdsm38209776d6.33.2025.09.03.19.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:38:29 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: vivek.balachandhar@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: =?UTF-8?q?Re=3A=20=5BPATCH=200/16=5D=20staging=3A=20rtl8723bs=3A=20style=20cleanups=20=E2=80=94=20please=20ignore=20v1=3B=20see=20v2?=
Date: Thu,  4 Sep 2025 02:38:16 +0000
Message-Id: <20250904023816.216762-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
References: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg and linux-staging folks,

Please ignore my first series — I accidentally sent patches 11–16 in a
separate batch so they threaded under 10/16 instead of the cover letter.

I’ve re-sent the series properly as v2 (same content, correct threading).
You can find it here on lore:
https://lore.kernel.org/all/20250904021448.216461-1-vivek.balachandhar@gmail.com/

Apologies for the noise, and thank you for your time.

Thanks,
Vivek BalachandharTN


