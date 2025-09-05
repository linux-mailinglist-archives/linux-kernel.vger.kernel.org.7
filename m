Return-Path: <linux-kernel+bounces-803744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D97B4648B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8589172859
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8852D2472A4;
	Fri,  5 Sep 2025 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kdjrLk/D"
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF6D315D25
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103543; cv=none; b=hC4/gIrAAAEEXLB2otUTpBp0Oht1E6QCLQt0F7Ode5zcdOI8y/BAxdPUa/JESyEmLFS5NouCJFqI4C+wuZ+mJ4fiDQ/CKwIVpWWJiN8OLMH4dVzIGamYrDmbVelqSvpi/bEmH5BMlQjJVKxPwXlC4Oqj8RGv2viAUcw3nVicfzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103543; c=relaxed/simple;
	bh=bjqXUAf79KUCUbqbCzCHgRWMtFcc58o7u+jTZXppNLk=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=IXlmsAyPWsxlj6qdr3qoGLpDXmaMiM9ibxbUqUVxxJUc3P1gPRlSU7LUNh2lZ4aTxyttK6diHDooEyGVswjZnVVrNS6jIn1vaZAK+jsFEmGRMq/7hJuIJkUv98dGbWW3Op5jOeQLG2wWR44+BsPkVBGbJVxtc1drVqWRMaJ8fiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kdjrLk/D; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1757103531; x=1757362731;
	bh=bjqXUAf79KUCUbqbCzCHgRWMtFcc58o7u+jTZXppNLk=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kdjrLk/DMJtqiG6sZrUB1cI3c7ghO+glgeceQtUAwrBw2PpQ2x/5K2o2BYHiCziHM
	 3awrJiTz5y7BhJgzJTh4eLSQIxaXIWafxrKlgqpJL1VdauhOKHtbH5ho1usUVFi/Lx
	 TFWLsuzd8ECRToDRx/45Wavru7ZHik83SoSWvkXy6XG1ubaB1yUWxnwJyu7rbECp7S
	 nnxzQaReJ51t5VjwrzK+YJ+AkjAd+KulWYrnGbNjZXjjyfu45pVN7YrVuO3ulW88Qo
	 jXKl7jvGc6gC4yZA2sJ8dMpRnfNFweqa178gnJjO/myrrO8Nr/ixiaH2+G2rHVH5BH
	 G3vgb1obkqnUQ==
Date: Fri, 05 Sep 2025 20:18:46 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: trustno12025 <trustno12025@proton.me>
Subject: git send-email
Message-ID: <hu1fy7GyeOPDZ0nI-AB1FvQp1hen9OC8Uc0UqSnAq1geR1u7mzMKj6vJcLyrvI0r8Rr0B4jhIlqT3A3pE-G0OO5mSHFo7LpWhKznVSqVQrI=@proton.me>
Feedback-ID: 152332093:user:proton
X-Pm-Message-ID: a5191060eff886efb694812a7e0afa9219d605a5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


git send-email



Odesl=C3=A1no zabezpe=C4=8Den=C3=BDm e-mailem Proton Mail.

