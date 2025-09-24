Return-Path: <linux-kernel+bounces-830023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A8FB98797
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA8B2E0B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357E026A0D0;
	Wed, 24 Sep 2025 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bf-el.eu header.i=@bf-el.eu header.b="bOIFhe3W"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A6213254
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758697897; cv=none; b=SSYpwmCufJCVI5h/peCkomzVx5ELf+TPM62NUsL1BpqGLv31IKj6T0BrDbsk58xYzKVR9XAlGerttUSySZABWZfHmAWiR+WrmtB2gK3CoyvFbQyU/3g+Zso9PK8TGSx0jTaQus7vDegddzIOdMGekLw2z826LO3F9cIQVv7WWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758697897; c=relaxed/simple;
	bh=cxvr5CAsSZRJDNdRYtMZoIj357oOZL4e7J9kjcd5Bb8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=q/vXAOIfe83NR7no7JyIgnJOcMuYAwoDVyB1wEDviyH8WL2Rs1wVzkIh+cpv2aqGjJr8vGiOww6vQVCHBJ02DGdoAQuPr8e97m7wvz+xOide54HF10b7pVvPrl1c0efBZlVS13Vh9bWM8sPU+Iw+zF1uf8eJaJvGbvi92gD94Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bf-el.eu; spf=pass smtp.mailfrom=bf-el.eu; dkim=pass (2048-bit key) header.d=bf-el.eu header.i=@bf-el.eu header.b=bOIFhe3W; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bf-el.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bf-el.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bf-el.eu;
	s=ds202509; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cxvr5CAsSZRJDNdRYtMZoIj357oOZL4e7J9kjcd5Bb8=; b=bOIFhe3WyZ+y7LoK/dFFRYtOxP
	LYFuJmS6t4YShNLgHigm5/jFqCIlX3GVaLttKv4CsLraxKynl1Pel/H9xMoyd24sT3UPkpeumRk36
	YLhfAAXBOlswzYJJGQfwPM4f4P8a48Ma1f+F54JCbr411cXqck1iPZVmi+wjkOT2W61M+uWPXZCZL
	X4tH7OoxFTpk5ZcXxW/gOSHxJBALXeyAPq0U+zAK++kRK7DvbI7n4/mNKHkIG+oSZ8Eb/g42ZGCUc
	thFVvjdxRHmF1M/QDquxoLByoFIM0wboxuOV1tYEU6B8WYIHJBsMYEJiAi1e1wwaiISvpNT75PbYK
	GXaEyJhA==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1v1Jex-00FTAE-Oq
	for linux-kernel@vger.kernel.org;
	Wed, 24 Sep 2025 09:11:27 +0200
Message-ID: <e7d7a1d9-4fa1-4b9a-828c-42e96d490f68@bf-el.eu>
Date: Wed, 24 Sep 2025 09:11:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <budi@bf-el.eu>
Subject: Updated URL to shortform (was Unification in Bitstreams OS, Fair Pay
 Philosophy, Low JItter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Updated my web to use the shortform BF as mentioned in earlier mail.

https://www.bf-el.eu/

I also added to my youtube channel Crow Tracker (best of "Sound Trackers"):

https://www.youtube.com/watch?v=OaS0rwFs-PQ&list=PLWKu0MveW-Ku4iISMdeNmhPBlGnTJ7xxY&index=2

If adhering to Kawai Bit, maybe there will be fair pay money.

Light!


