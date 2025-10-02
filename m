Return-Path: <linux-kernel+bounces-840003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 921CDBB3530
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8C4544439
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69DD2F1FC2;
	Thu,  2 Oct 2025 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b="nV31FnIG"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E02DCF44
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394412; cv=none; b=TjJqx7XuuGq3GWqB2GKS3DPsyNsm4x11jcWIpMLoYEkpRd3rDEifQhUCYvsBlNk4J4N06yiV53KbhAsl38pN1dC1tHD3qbiezG47LvtVSlczkbrDlCpixAhGkz8GIbxFTOv926b5HByO6PHz3xebHmDY01uznjNrvDKov7sPIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394412; c=relaxed/simple;
	bh=uyYgWZVmV6T7lH9eIYagfPzPK5bUoUvVmkhsGkxK9yM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=jH9clQ5M9s+OY1y2iH1TRik3/3I+uUWmPmWh/yRncvjHhbk5n2Sclf75Rtyc62Q2QUAdVIcoi7z9wbjU7b0Olbnbt4U9hgVLyQFQqTTHkpKwoSQzGu5f52zzZ635pV3kqjkK68WRoB40ZDOVKq0VS+/Mq0csQLV74nsNf+e9XMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu; spf=pass smtp.mailfrom=bitology.eu; dkim=pass (2048-bit key) header.d=bitology.eu header.i=@bitology.eu header.b=nV31FnIG; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitology.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitology.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitology.eu
	; s=ds202506; h=Content-Transfer-Encoding:Content-Type:To:Subject:From:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KAkH9OW9mT+2h3q3Ar5lpI50/xrPRarNCXgPCemKYo8=; b=nV31FnIGLSm/j8TLTsKovsby7O
	M8Jskf8DjgDb7mFkYFrQrkWQUvHvIOGo0W65DkTWkf7zvpFPR/1h2pkYHS6yzSvXiGIOGea21GPVl
	cMeJ8+4IQQN2gBUHwGpYllM1fdEbUZ1jUJbF1TjUHgBSdaFpB7M8N/dCgWrIlHTE7yhGQmeuv2Rv9
	I2HcDQgAtG/AgRGANU/YPRZjjlKcORdOzBYM8a/s4reKIsLpa+1cKKJFk5oWmEHYhBa1heZp+9n5Y
	EkiLp/qFRVjYVUrNXOkRRXORT4nu6G+Q4K2RtnNsSKD1cwD5pSvKmOPmqgYpXQPW8gSo4GNwFYTNQ
	JavaSVMQ==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1v4Er6-00AKkj-UR
	for linux-kernel@vger.kernel.org;
	Thu, 02 Oct 2025 10:40:07 +0200
Message-ID: <88726a13-8ad8-43ab-9155-5fe4a715aa2f@bitology.eu>
Date: Thu, 2 Oct 2025 10:40:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <budi@bitology.eu>
Subject: Updated webpage: Methodist Philosophy (was Fair Pay Philosophy,
 Unification in Bitstream System, Low JItter)
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

mSLIM really translates to Methodist, so I have updated my webpage.

Unification in Bitstream System should happen. These are the Bit 
Hackers, that are against Bug. Corrodation symbols in the kernel such as 
Rust and Germs really count as this. So we want to separate from this.

With a good Low Jitter system, which good computing really is about.

Suggesting Bit programmming language, phasing out BCPL/C, that can run 
natively on a Bit CPU. (1/3 Bus Use)

The only Budi approved system.

Hail Eln, The Real.

Light,
Ywe Cærlyn.
Budi.
https://bitology.eu/



