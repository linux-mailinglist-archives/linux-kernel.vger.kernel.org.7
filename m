Return-Path: <linux-kernel+bounces-774998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E3B2BA28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBCE3AFFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4A026CE12;
	Tue, 19 Aug 2025 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnZMMbnw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C0209682
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587042; cv=none; b=dqFo5VJE0aJAi9rJgqdXA/8XC4Hjbf4MFz5Y5FE0HIwk6pW6IO3oOp9wMhnHyOeIuL12NqmcLBcqme2qnAW+NfC4ML12shLJfe5BY1wehUBa6gJbhGrmCo62q3z3qnDd5WFNrTeiw5m9iU72nzFSxfLuwqscPpUxWf0YOSutscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587042; c=relaxed/simple;
	bh=0vu8uRD5MfWdeKle5bX1tsYUWtyclem5Lnk7ypt5keg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqKn4mbzfUrN6lQkjtivibTtIVOfcGOu0w0b377Ts7hT9Z8SuwNhqgztjWN6Zl4rv3Cyqj7VTKuOFzyj6D8GqcvdJtZmHzY+EbdxM1K8qx1Wmfhim4jo9vO9HnAWJHYHxpTIScSkHfJhThG07xN7v1hCAhwfCRKM75jId4RGktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnZMMbnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C4EC4CEF1;
	Tue, 19 Aug 2025 07:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755587042;
	bh=0vu8uRD5MfWdeKle5bX1tsYUWtyclem5Lnk7ypt5keg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnZMMbnwDepMMdrzLL0FMHs8XKjuH5O8zJJAb02gh1zm3KVMS5Iyz4ddN6dtYDmgb
	 3ZnAY1SlabTIbOpmE5n+IaNdm2Agt8dnsRW1v7je2PzwjLhq+nEFKo7L7q0KWw3oYV
	 5zkL5w/4XaH89lzmtb0edWZHdmM/2HeXuXXr/AOzK1kkdD1pkIseS7lD8eBc+3xNjE
	 lM0d/N4EbS6wQunxFhA/6AC++33/wfQuaaym34QvX4ptZWeFc/fqIFgBuKRm9DKajq
	 QRiB8P76JiVVr6IYwfQLD0CrSBvmkXHQBEQgSDhgswbpI4Ecfv4S/mDhYDQ6aHKAxA
	 KYIfsXE+JOAIA==
Date: Tue, 19 Aug 2025 09:03:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: dri-devel@lists.freedesktop.org, 
	Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm: bridge: Add TI tmds181 and sn65dp159 driver
Message-ID: <20250819-asparagus-dogfish-of-greatness-ab089e@kuoka>
References: <20250819053205.9976-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.9365be0b-205e-4d59-ad18-c1924bf45277@emailsignatures365.codetwo.com>
 <20250819053205.9976-3-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819053205.9976-3-mike.looijmans@topic.nl>

On Tue, Aug 19, 2025 at 07:31:15AM +0200, Mike Looijmans wrote:
> +	switch (data->chip) {
> +	case dp159:
> +		val = 0;
> +		if (!of_property_read_u32(client->dev.of_node,
> +					"slew-rate", &param)) {

You never tested your code or your DTS.

Best regards,
Krzysztof


