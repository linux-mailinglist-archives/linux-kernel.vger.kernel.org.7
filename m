Return-Path: <linux-kernel+bounces-891329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4AEC4273D
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 05:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD27188AC0A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 04:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11875284884;
	Sat,  8 Nov 2025 04:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="JC8lJpqV"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ADE23E359
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 04:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762577670; cv=none; b=r9S2iMY6VkLCjeWj0v2XDz+DMk+4WinEv1ubYmwdRZ6r6DLa2rRjVheVK309QYo8b63HSQk1NVed9V3R7zOT/utwZ/Xw6NIcRgxRLGkg/+fzViZhhLiPGskN8Y+waputRfqAZEucpPxzHj/MeYF46Ib30Xg8C4i+LTkn82JmWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762577670; c=relaxed/simple;
	bh=FJ0z1Pw91C1KXDxkISNCpi29zWmCs/T2mvQmzcQzaNE=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=gA7Vt9DP/Z/HRY+i3lkSgO9CKQprSFKYR2J0+335O6lmqS1KJccH/aObl60Iy5N/FEzQmOuLYqThU8j64TN/HaRrWK1ZzEozWpIfiPv7YwGeaqlin4Imkx1gP4I9m9KN5vVA+z347rf0AqKJZ1BXk0LQ9E6Ajcy/8sUpN+nVvwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=JC8lJpqV; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1762577658; x=1762836858;
	bh=WOoEZbPGGZXaVMi7xthSdL2YB8sqg8DisbydO2JNEoA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JC8lJpqVQvINvHFAhLvDtCS0IS41ay98Jqim4fX6QyW48+YF8HwFJYsu3wKw+hfnh
	 z9eOe2AHnNVKC8XhPxK9ye1lLve10om0s2VXPFe4Tk5AoDjesEvQFuQm7+uru3SGXq
	 myJ5q1iuAq/XaKNV33Lse4mm4UZoPFnZJlpHQqG++uNbj3NK463LU4vvDqpRu2uQlJ
	 axSi0ZIjQZEo+MiacRh6JkFZrCWffja1KqgtUO8PJsNzlldRoJ9tx+aC9lWZ9hdGAO
	 EBdw5neCMddA9ZuuFmF/AaXk8PnuB6A11p0M+kA+EXZzlmDmyM1frQYE5Me5a+dQ3j
	 buw81x48DcR6Q==
Date: Sat, 08 Nov 2025 04:54:13 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
From: Bryant Boatright <bryant.boatright@proton.me>
Subject: [PATCH 0/3] Checkpatch cleanup patches
Message-ID: <cover.1762576396.git.bryant.boatright@proton.me>
Feedback-ID: 74848953:user:proton
X-Pm-Message-ID: d0681662824020a91077f8cb6c632209707a9e75
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



