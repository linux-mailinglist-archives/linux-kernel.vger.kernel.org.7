Return-Path: <linux-kernel+bounces-732825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052BFB06C77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0054450438F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D75723ABB0;
	Wed, 16 Jul 2025 03:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nHoU+jzO"
Received: from out162-62-63-194.mail.qq.com (out162-62-63-194.mail.qq.com [162.62.63.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489B1F4CB6
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.63.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637971; cv=none; b=CvpTL2ttJWV1pd63VijPBzSb/Uhm3sTxHOdXWO3axOyFTN6YMvlojsNdMZQJexSB236o47bwjkw9bhDoLMWmdkSZutEr9JZ0TjJWnvmSZpyRNLMtodZWrbbOFB1w28fCQb+/ITALjLvWOVK7n/Icdn+PRS5hfK4w23woFRFhfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637971; c=relaxed/simple;
	bh=6VN9FKcTdtAorxviZrZKH9YBRb4tZy7sSEHppzE3GAQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=c94AwmKm0rjZzo0mlag54b40xMw7y+klrMLidsbRPQFm+jMsQ1kpy9R7zoLZJejnjCWIL7HoDaFLfYRjSimUvZrdOeTECnS614gjwFu5laALp/NxZuadNK/aSnEM44e2YQbwQVbmnjXfHKUE3lt6dUhWIqy4d6aasIj8CBez7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nHoU+jzO; arc=none smtp.client-ip=162.62.63.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1752637963; bh=YUlCVgMJNmDjwrdJ6bJdu2yxm+8ftSfwyAUkzwsQpUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nHoU+jzO9qnVdxvNiVVa3YRG/cO2orLj4eoG4HV7MewMHAH0UgXEoIuMiJu4vUXuX
	 o2YR2TIvssRzpwaF95MKXkDM9K+W4x946qVre595u0g2mpV8TXRS48hxgWKTbZvF7T
	 ZeLnKI3dzGykTeHXzFkYA35b6DdoyEqaclP1F5Fw=
Received: from VM-222-126-tencentos.localdomain ([14.116.239.33])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 2C00BE3E; Wed, 16 Jul 2025 11:11:00 +0800
X-QQ-mid: xmsmtpt1752635460t8c7enoyi
Message-ID: <tencent_725B64FFA3A4BBF7C3E67C14D2B43A5C9107@qq.com>
X-QQ-XMAILINFO: OCPaXsGDlF8+lftE9NFAJ7mWAyp1NovPO6/docXm32AEKrxvRHuVA8D+uTio6w
	 Ro0wipK2wFoolbqrwMUvc6BRSxd3kEMJlhHmBczdiEBpn+q943midwtLpSW/yhp5CMFeiTElEb+Y
	 Mh5QItELk3hCBgHpfNSCNb7qpKa8fHm03PMTN2QIY+L2oKelLZQcnh1lYqhvUhpnZGqlOcj+9eom
	 o6iNjmxRObYGc1a2lZ4bcYTPTYwrb1mxeuQz5cBDYRacAlhw2RszvucKcWr0KVOdTTtGCJBvruA0
	 T2ALRQHnhNPXVLJWeL954pjLD1e+8DIYPpITje0VTZI4fRfpT/4nRLTXBfRKSoFdEPT4XnZTnHDM
	 b1omVRq0suasKAfkyBJq9GU4Qv9wlj/A/04P/rSbVQvgGhrB9SjZNKhIaIAzq0PhsmzaHx7E62eN
	 QTmYUPGDf0aVCILKpQg8guPSo/yabGiht9hk/385m8LbUkvszvfexfHnQSCHsjRSMR7tocBLwic1
	 ruqxGC58qIFvJzzh4iTOaPMvtfdPtpcC0MwUyUYyWMe/ifg4iw6i03pIyFkqorohOovcryMBb4vm
	 Kv2IPguFOD3RHsXe80Yl4Mk9+8AYCHwpeOf13JSM14gefScDKroGrejMsaIjxpjaRi04IUbw2Apd
	 hssmqTANc9dSkS/r7loo3CLMTfNBJbWMIZKNyuKmXfHkzZNEKBXawU+Ovn4QNpa47bWT/B6DncD8
	 X64mz6HWbP1xW4nVFHSnXUGV1jjbGEUeORVgOgFBWZrURlQZV6lDsXsYGJdXf5rOAinB1R0hPQ9G
	 VMuQ7Of1PqR+rOGr4az3wMgVJQPPBjrPvDlrOEwidIJiF1X7W18tG3UzU7YBOxRUMdTlU/BGhP1n
	 SiAgsA4ruBlC5QCDZEuWVp2kPGRLUv2dvl4yMTBANMycXIXR/EkTkqknnTTPRUNSvNKW3efZwlpT
	 dyxiUgG+UFOMOEqaQPoaCbZsvA+6c/DjW9cOgJQYQ98xdVB5LKwxX+ntGGUGWtM2Jyq+pnLyUlah
	 hPlWwfrQNKiEgl5HJsqPiKbYN6AZAoUzi9PadaTQCDTT6JDcGa
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: jackysliu <1972843537@qq.com>
To: krzk@kernel.org
Cc: 1972843537@qq.com,
	Austin.Zheng@amd.com,
	Dillon.Varone@amd.com,
	Security@tencent.com,
	Sung.Lee@amd.com,
	Wayne.Lin@amd.com,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	alvin.lee2@amd.com,
	amd-gfx@lists.freedesktop.org,
	aurabindo.pillai@amd.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	harry.wentland@amd.com,
	joshua.aberback@amd.com,
	linux-kernel@vger.kernel.org,
	linux@treblig.org,
	mario.limonciello@amd.com,
	ryanseto@amd.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	sunpeng.li@amd.com
Subject: Re: [PATCH] scsi:bfa: Double-free vulnerability fix 
Date: Wed, 16 Jul 2025 11:10:54 +0800
X-OQ-MSGID: <20250716031054.3964061-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <12c6632b-65b7-43da-a954-7107ac8cb1b1@kernel.org>
References: <12c6632b-65b7-43da-a954-7107ac8cb1b1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 15 2025 12:45:00 +0200 Krzysztof Kozlowski wrote:
>You should disclose that you used some AI tool for that... and that
>other report(s) was really fake finding.  People should know you
>generated it with AI, so they could make informed decision whether to
>even allocate time here.

Although this problem was detected with the help of ai and static methods,
I checked the trigger path by myself and verified this problem. 
I'll describe the ways of detection if I find other issues in the future.
Anyway, thanks for your review.

Siyang Liu


