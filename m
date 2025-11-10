Return-Path: <linux-kernel+bounces-894039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C628AC4921A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D46504ED231
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF0B33BBAE;
	Mon, 10 Nov 2025 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LAtEwdky"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BA12FC87E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804114; cv=none; b=SkAB/jrdnvu5AxoKE3c+WrzYxr2uZP6qxQ5KqWn7fENuqXNbXCKVd+QbAkwwUeolP19XGEGfPIX5DRGnfyUm7FMLMkXDz4TNLf3i5ZVVArM898uwLj9PIyLs+hO9S8cqUPr5IhuA6s1rs1d9xVwuWunhgm/0fpEv/7RDOEdYX3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804114; c=relaxed/simple;
	bh=FJ0z1Pw91C1KXDxkISNCpi29zWmCs/T2mvQmzcQzaNE=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=UrFaXvGEvOUtjcjxqXnUDHCoWpqBTWka+3DNR+DrLJXHfHdGMrLNVc4649mN08+taW1GGD1K9Zd2qX2ZBUMzN8ThyyZewUV37X4HtT8oxaoc5TFH+WADpwWjHPtAf1dKPOpA9GRWTl57qqTVvA28V6CbiAGpsUVFbbZzN8UhBhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LAtEwdky; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1762804105; x=1763063305;
	bh=WOoEZbPGGZXaVMi7xthSdL2YB8sqg8DisbydO2JNEoA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LAtEwdkyUV4bPJqsFmQfTfXzlkX9FfSEidSg+IHW79ZLypng7I1eC/PwUr3VCOC1b
	 OAg0V2wwT0ebZl1X5boTo4qbO2p1eXAupxAxpwZwx/q+STSMxq0jaX9CIbBFuctiy6
	 PkAJs6NWL0rihcYJo25n/AQKxCtj+9vXPexJbMvNcOMctRGvXt8mG00MBggVISsPM5
	 p4DKuhvu6ptk1sdpdF6q0OpA45Fb5d8hMEv7Drzy3aqP36Ks2ievfIlhBb4trMmhAA
	 5yj3XOI1/3gZn0Lu9W0D9Tj9zGasClETTlh61+g9vOC7JsRSg+Ns8tdOZI3SrWMQVP
	 kLjH8fCu0q4rQ==
Date: Mon, 10 Nov 2025 19:48:19 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Michael Straube <straube.linux@gmail.com>
From: Bryant Boatright <bryant.boatright@proton.me>
Subject: [PATCH v2 0/3] Checkpatch cleanup patches
Message-ID: <cover.1762803720.git.bryant.boatright@proton.me>
Feedback-ID: 74848953:user:proton
X-Pm-Message-ID: d6dde83950adc7690176f56a37f26c0281a061e0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Correct camel case names reported by checkpatch.

These patches are not required to be applied in any order.

Bryant Boatright (3):
  staging: rtl8723bs: Rename camel case enumeration
  staging: rtl8723bs: Rename camel case argument
  staging: rtl8723bs: Rename camel case variiable

 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 40 +++++++++----------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h |  6 +--
 3 files changed, 24 insertions(+), 24 deletions(-)

--=20
2.43.0



