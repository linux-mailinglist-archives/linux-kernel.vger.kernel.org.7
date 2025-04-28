Return-Path: <linux-kernel+bounces-622928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5511A9EE88
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 13:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0D53BF69D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 11:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B21262FC2;
	Mon, 28 Apr 2025 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Nw2GXPKJ"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2274A35
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745838411; cv=none; b=bVewn0Sc/CsZ/PohrkTu51zosjGTTOY61gMRu2gsVNo7u/FIijGcS5O58tTy1G9hNFYgtOwsB2tQmANNk8hGbXfDMEXhYNC26I7oOToLGOPFrWJQgQlg5bC/ZiKWfZ0WjNYUiR0ZXjpkLJdNHARIEFLLim/UyCqJTX2hoirNEug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745838411; c=relaxed/simple;
	bh=mTlNH1sPWvqO7DlDN8VqLB553zvnutu3jibMYK0nBsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE28Urh3+/KF6hIfSLV0aBc/H4usVW+Y3TnvLVfVo029iAE/JoVU6PGL6PCTvSuj//feuxXwjg4loeS5gknoUrANoAwU5F9XgdjRaJR9M5lORzi5TTouwY4M1bcjGtVoIZC1G1Eu2CyK9JU8yHjNS0SfkMthiI/R7g7zlwb3vwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Nw2GXPKJ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 01618470B7;
	Mon, 28 Apr 2025 13:01:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1745838086;
	bh=mTlNH1sPWvqO7DlDN8VqLB553zvnutu3jibMYK0nBsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nw2GXPKJncHOuNwBdWy1WCUSBEQEF+9MessJVwFGdhPpADLSHeAfsQTH1P1uhPVUe
	 0LpSWdIaYNULUDux/uOldscAAzNPnyRw9U4+475DXVpL97VaXvUkdxq1bq/6x+93Pv
	 txg1DROgNNen1R3HvHmtcZYXkzApFMv4YcxQs2JDNv8z/r/Yswnt0pw3jcymdhGDZC
	 OttdZaPELIfAUgUSPWXISh8GmyFLsvMaGb4LkQ2eeccL/wh7kg5LzuQUF7ZAO4w/Rt
	 ox4W7lYzLw+pCKXIeDxIp8VBjrI6yg7iM+RFHMB3RlmQRoWODtaKfWwdaVKz9vd56S
	 ve1YajMQwxMqA==
Date: Mon, 28 Apr 2025 13:01:24 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Mingcong Bai <jeffbai@aosc.io>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.15-rc3
Message-ID: <aA9gBKhFo8-rIYSo@8bytes.org>
References: <20250418031642.1810175-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418031642.1810175-1-baolu.lu@linux.intel.com>

On Fri, Apr 18, 2025 at 11:16:41AM +0800, Lu Baolu wrote:
> Mingcong Bai (1):
>   iommu/vt-d: Apply quirk_iommu_igfx for 8086:0044 (QM57/QS57)

Applied, thanks.

