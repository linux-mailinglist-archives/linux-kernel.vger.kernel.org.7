Return-Path: <linux-kernel+bounces-835603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5710ABA78E8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108E6176EE5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 21:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0C4255E53;
	Sun, 28 Sep 2025 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAWZuSOY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A221DF73C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759096580; cv=none; b=bvP3zMDRj07FLR9MnD447VFqpLXBztzinu4fHiYGGVl3G74uKyBLGA+PYcOM17ipN3lVz66cqLSNwuaQrxB5oJkoF1fv/EhVLFasLTj8OWCiFqI2bbKLVCFLfztMsRqpyVmdLZ/k5F5pTY1GMZdRtdy6dz/HvnwkxFBIJQ4mapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759096580; c=relaxed/simple;
	bh=Ag5OJvTMxXJDeRviaTg2QX6h5X6prtIOT5+vV3Pl5pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIyXU5pKi6z8hK17I8D1Dg/MHhzHh6rd6F1BTdxYd4a2U6P7blIcXbOk8IQK9fA1esFT/c3geAeAI9YyCXalwSutF9uXl4rXIllxwbN2ZDi0EoZbwvXWOSvz9LM2GmSnrNHxnxYpCaIschnDKYYVffbMrJxW9fcZBqW8g1M5Wjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAWZuSOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED47C4CEF0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759096580;
	bh=Ag5OJvTMxXJDeRviaTg2QX6h5X6prtIOT5+vV3Pl5pc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UAWZuSOYJ3j9hQ0fWorFNYqEBsdus6cRQrTLw3KiJj0mUCPOHD22dEawatpChR7pL
	 zzbOi1CxWDKrhE1/uMPXpHeGXxzlcoWg31PTg/0mhiHowjY9JWhKlOVB0dfgyT8r+B
	 53D4w/py+/LWGXEmrea0tuBb9gBTJU2R3A6C2tXCuoUOlh/RLJeM64TfpFFdhBn7Rt
	 N5PgqfNxjfRR0hMe9oUSTb7aBpy3wt7e9GFJ3qToxV/wx8xQcyyXRTCrYUwfZgrhSQ
	 AurjXItdn4/usrZ0TYB4UoDcOisUFS6GAtc4AvlClRMKdDqH27RmO1Doq4Le02wZQ0
	 OGXH6+fNP4Xpg==
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27edcbbe7bfso41352765ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:56:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPjStPkWDq8dd+4V48/3xWAEVwfPCwKgB0sKnlJEn/7CJY3iQHO6VU1lvyoPoL/1BOeRVOoQooqMMfpYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmzG+X32BtshQrx3pXnwTtbsa7JT/+8DSUyi27BFVM+5k8Xx08
	RANBK8BtAtZMIJwKbnh/6o0VYsxmuB0lnP4N4A57oOlPTvP7ySK6e0BKJ52I08+/ZdYfUOtpkJ9
	OKVZcZM+UMuJORzkYnHSah8PjdxaNkhk=
X-Google-Smtp-Source: AGHT+IEmvEYVOc//pmIHeQbDnEcLXjslRWP9TUnzYJfx2tg/laNf7LCCb9RFTpKOInRVNDKY0Rk2d9ibGpbC2jNixjo=
X-Received: by 2002:a17:903:1aeb:b0:27e:e77f:57f3 with SMTP id
 d9443c01a7336-27ee77f5934mr118692055ad.14.1759096579693; Sun, 28 Sep 2025
 14:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928-exynos7870-dt-fixes-v1-0-a40e77a73f16@disroot.org> <20250928-exynos7870-dt-fixes-v1-1-a40e77a73f16@disroot.org>
In-Reply-To: <20250928-exynos7870-dt-fixes-v1-1-a40e77a73f16@disroot.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 29 Sep 2025 06:56:08 +0900
X-Gmail-Original-Message-ID: <CAJKOXPf+fASV2WP+ix_6qb+L-0WqsqLAG7K7FxeQgscsbOUsOA@mail.gmail.com>
X-Gm-Features: AS18NWBY-JzZiyqDsQSGva_Q19zCpOwf1vpPOKC71sJ3_Roa16ez0Y1PkZhVmYM
Message-ID: <CAJKOXPf+fASV2WP+ix_6qb+L-0WqsqLAG7K7FxeQgscsbOUsOA@mail.gmail.com>
Subject: Re: [PATCH 1/7] arm64: dts: exynos7870: relocate ${x}-names property
 after ${x}
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Sept 2025 at 01:44, Kaustabh Chakraborty
<kauschluss@disroot.org> wrote:
>
> All ${x}-names properties are conventionally placed after their
> corresponding ${x} properties. For instance, 'clock-names' must follow
> 'clocks', 'interrupt-names' must follow 'interrupts'. Make necessary
> changes to follow said convention. No functional changes made.
>

I don't intend to take such cosmetic changes, because they interfere
with stable back porting, unless we have a tool for such cleanup. Did
you use my prototype tool for that or some other tool?

Best regards,
Krzysztof

