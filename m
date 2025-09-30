Return-Path: <linux-kernel+bounces-837473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AD0BAC639
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946D11927655
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C372F8BF5;
	Tue, 30 Sep 2025 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGgZ//X0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389E2F7AB4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226471; cv=none; b=mCHm2zXL/T90GPqedeUVN8t9iQ6WC7mW8r7Hd9uvwTs8MSJr3G7U2tgbtZuUiN6PhnXM4uNGVZmJnNjpzcWlvAaaQpGgiaihdfpHoDCECtN3SQS3ZdkZU2XVVRpko+LS1PNrSRaWS1Qwf5QX67mAQTpg8ZdK4AYKXuCn5f12m8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226471; c=relaxed/simple;
	bh=y05Kz2gaTyYjB9whqH52OCf8XRzeXuk3uaiIvAlC1+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxhTgKJh3lQmpoqwbS0rfHjZC+NGaVXyKOrMlEi616h1NNVPjS9d9NWHUBAcD/wBEbmU7d+kSj1mKG8IhontmoCM2oUTJjwGI9563ZGpEWCdnsFkglLVDbC4HLtaP/K+zP6GaTMWyMNMuDmcMXaWN8WmXtRhKMsw6FR3iaQL0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGgZ//X0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A04FC4CEF0;
	Tue, 30 Sep 2025 10:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759226470;
	bh=y05Kz2gaTyYjB9whqH52OCf8XRzeXuk3uaiIvAlC1+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGgZ//X0JaFXfSHw2fnz0fIWtNfOu64jPTwQ5wkp0zhLLH/etqILUXyFh+rlacsEL
	 p+6xGOTdZEu0dnrTBDCpucfPWu/ya+gm4JSblyBipfHWwLHQAWWEeF2+rmuQwonPlT
	 GzH8q6qKib7Jyhg73bL6+IF7CMeIJ4vvUSZ4hw8a/O8gV0C6z9aAtcRUXHIzfCn5+N
	 rnoc7ZGgK5ET1mGiUDuDQONaFziH2ODa0uYw3bp5cCX7ytVzBbE7G6YgQ/44dU0Ofz
	 j3bkHMqOvvNrmpAHmTEjDR9WLQ3LSbOv8FqI7GTEsLh3dM1rleJr2qzTM+UHhaLqyp
	 UIH20r01WoeAw==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 21/29] drm/tidss: crtc: Implement destroy_state
Date: Tue, 30 Sep 2025 12:00:50 +0200
Message-ID: <175922644629.1134117.16089467685149980976.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902-drm-state-readout-v1-21-14ad5315da3f@kernel.org>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org> <20250902-drm-state-readout-v1-21-14ad5315da3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 02 Sep 2025 10:32:49 +0200, Maxime Ripard wrote:
> The tidss crtc driver implements its own state, with its own
> implementation of reset and duplicate_state, but uses the default
> destroy_state helper.
> 
> This somewhat works for now because the drm_crtc_state field in
> tidss_crtc_state is the first field so the offset is 0, but it's pretty
> fragile and it should really have its own destroy_state implementation.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

