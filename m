Return-Path: <linux-kernel+bounces-688333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6DDADB111
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 15:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB331168E72
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 13:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8872DBF41;
	Mon, 16 Jun 2025 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF8r54ma"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342529B229;
	Mon, 16 Jun 2025 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079134; cv=none; b=CVn4idOz2VV9cOVHOHMNTtzeGjpJpJTtQC47oR2HUp74bmDbqVuy8Y9adpWgbBKHMaRit9gtJPSG7NWC+V2oFe1ukqa5U1lHUlmJHTBvgg6WlMXs6hvdX+K0n504mfxxT5MHiOsGrb4izAUjW40j2OnR0ZMrN0ZNV9fhNQAkM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079134; c=relaxed/simple;
	bh=t0JMBfBiTDh2FNYLfPkkjnYHrm08fBNCDYTeqxlKy/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cjf21RUKrvolJNjiI2cKnfTu+M+eoMWepbAJCE9fnoYaSaKIFAq0KW5qIpEin/WMzP6pJ3DC8RFqw6dTrLOAh2WbzVQS2KoogWuLZh/fFwnmhyrmQI1iDOEkQIQhAjzgx8jZ6Wx8eZm7ZY5VhPcG+Zs8fM6uxpYudiPeQ5pPAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF8r54ma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0429C4CEEA;
	Mon, 16 Jun 2025 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750079133;
	bh=t0JMBfBiTDh2FNYLfPkkjnYHrm08fBNCDYTeqxlKy/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eF8r54maNn2NcTHuaf6QNkp/cGyzHK293NNEqp/kth1LcOSVIlmbp9oh8Fm4JTSIg
	 w789MZqheUYObGmuGXE39vcSetpYQY73zuTsqSbRpnOtf8xTDjRBoTmRZMYyhnBghM
	 PaS4RGWmJPRNqpXtvgfJBDUL5q3vdQ4YoEAR5y+j/Y4Y7iPeYBBEgkNjhJTw5c+OUB
	 eJS+LT0qgHwl2mv3lczzcTkwH0I7dGBmo358A2umzLN9lOqZF23Zng02nXZJ/Tzy6N
	 HMW0d0X1m7drpooTbZNkD0FrSX7ZWPCu62XbXBlabhAa1TwfgDv9fxyu8vGG35Qdm4
	 fg4eGPFJWj+Gw==
Message-ID: <f9275079-842a-406e-8bb7-b22a22b7c7e6@kernel.org>
Date: Mon, 16 Jun 2025 15:05:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] media: uvcvideo: Enable keep-sorted
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hans@jjverkuil.nl>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250429-keep-sorted-v1-0-2fa3538c0315@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250429-keep-sorted-v1-0-2fa3538c0315@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 29-Apr-25 15:47, Ricardo Ribalda wrote:
> When committers contribute quirks to the uvc driver, they usually add
> them out of order.
> 
> We can automatically validate that their follow our guidelines with the
> use of keep-sorted.
> 
> This patchset adds support for keep-sorted in the uvc driver. The two
> patches can be squashed if needed.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

I've no objections against these 2 patches, but these need to be
rebased on top of the latest uvc/for-next. Can you send out a new
version please ?

Also for patch 2/2 can we not just add the 2 keep-sorted headers
and then actually run keep-sorted to auto-fix things ?

Or can it not auto-fix ?

Regards,

Hans



> ---
> Ricardo Ribalda (2):
>       media: uvcvideo: Rewrite uvc_ids for keep-sorted.
>       media: uvcvideo: Add keep-sorted statement and sort uvc_ids
> 
>  drivers/media/usb/uvc/uvc_driver.c | 660 +++++++++++++++++++++++--------------
>  1 file changed, 409 insertions(+), 251 deletions(-)
> ---
> base-commit: 398a1b33f1479af35ca915c5efc9b00d6204f8fa
> change-id: 20250429-keep-sorted-2ac6f4796726
> 
> Best regards,


