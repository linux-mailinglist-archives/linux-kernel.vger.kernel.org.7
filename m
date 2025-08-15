Return-Path: <linux-kernel+bounces-770596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96FBB27CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A0717940C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952522D12F6;
	Fri, 15 Aug 2025 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kotiuk.pl header.i=pawel@kotiuk.pl header.b="WpMNpQ4F"
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F1261585
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249221; cv=pass; b=nbDPGMFoH9sm9yVMauqQmW5yjlEI0np+JkFw8yMQzEOmza24NwzvHcU3wub6OWI4zOCuqR/eijlzN79HJCk1gkg1I99GxAHtuBRnHeJVgMYrIW2/55X2CZ+SCjaJnsIrTYchRoXfelJRX0ckV8v5rCbz4DmNtrEYduJrOAcNsyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249221; c=relaxed/simple;
	bh=p4FCBpD5L+4TcZHxjq0b1lI8voUcTe1NeYkiZ3hTzv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=As9fsiFv3qqXIDvUy97A+9bTNBzjvgbuEywURQFk4F90hpsapDHhsUpmxco/EUxW6j5pQkuQG+dnDEH/qlfbN+zTsBkHWO63jBVe+uE5F7VK8+UyW2om6UHT2/TIQuDy4gpQ91kNDkN8JDByN5cNTLgIIvTlWuhRiYd+oR6g/DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kotiuk.pl; spf=pass smtp.mailfrom=kotiuk.pl; dkim=pass (1024-bit key) header.d=kotiuk.pl header.i=pawel@kotiuk.pl header.b=WpMNpQ4F; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kotiuk.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kotiuk.pl
ARC-Seal: i=1; a=rsa-sha256; t=1755249180; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=cZwtvcpL0VN0RXUv3ngQCyXLE7x6jZ1xOzPBa8ddaW8OVV2u9fBVu7tTv8bHiTmBh6KVuFW/YvRTIMHh+SEfBCED1XBPcql8IX73kiCXVzH+Hb9sDiLZrv/EM+BAHV8sAnLokk9NZjUVo6SzmpEnan2GaydEp/vBrvgFnBtNXL8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1755249180; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p4FCBpD5L+4TcZHxjq0b1lI8voUcTe1NeYkiZ3hTzv4=; 
	b=A2bxwGeAieh59kOJBbSW7KOh4+jUFApftKGY6KzGIlBWjTPyot+ZXDpxLMMZiphhzryja+hOZ9HHIcTBEuxCe0TmsUkmvBBd+iQ7z/NyRlIb1wBQO0bd9gwWI3V3EopUbt1gC8/Cv+Dm1hT2TDzm7VVcRotHdZwNcfdnczGZS6I=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=kotiuk.pl;
	spf=pass  smtp.mailfrom=pawel@kotiuk.pl;
	dmarc=pass header.from=<pawel@kotiuk.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755249180;
	s=zmail; d=kotiuk.pl; i=pawel@kotiuk.pl;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=p4FCBpD5L+4TcZHxjq0b1lI8voUcTe1NeYkiZ3hTzv4=;
	b=WpMNpQ4F3+cG0FxEsirmI2V87GagTD6as/mPxpTL3nNyzOc8bhVlvqBrVmR4z4o4
	8lsEwGqShTwApRG7yx5AN5B9cylvZndA7a6MH2+1BopWpbQZVV5QfA+IWUsenHctzSK
	EJBJwN2zsIOuM1qFrJM4QChlL1BZug1iI3pEgQbU=
Received: by mx.zoho.eu with SMTPS id 1755249179060498.36275145621505;
	Fri, 15 Aug 2025 11:12:59 +0200 (CEST)
From: =?UTF-8?q?Pawe=C5=82=20Kotiuk?= <pawel@kotiuk.pl>
To: bnatikar@amd.com
Cc: adrian@freund.io,
	basavaraj.natikar@amd.com,
	benato.denis96@gmail.com,
	bentiss@kernel.org,
	iv.dovg@gmail.com,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luke@ljones.dev
Subject: Re: [PATCH 0/1] HID: amd_sfh: Add support for tablet mode
Date: Fri, 15 Aug 2025 11:12:50 +0200
Message-ID: <20250815091251.20737-1-pawel@kotiuk.pl>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <db1d95be-e92a-4328-b43e-8214a0b520be@amd.com>
References: <db1d95be-e92a-4328-b43e-8214a0b520be@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

> Sure, Jiri, I will get back to this patch soon.

Hi Basavaraj,

Could yougive us at least a rough estimate when you will be able to check this patch?

Thanks in advance
Paweł

