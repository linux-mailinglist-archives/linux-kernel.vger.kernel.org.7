Return-Path: <linux-kernel+bounces-780453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24FDB3020D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B7FA07759
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C8A2FB63C;
	Thu, 21 Aug 2025 18:27:48 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D12E7BC0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800867; cv=none; b=u5O7VGkyhQH1yV5AVom8eL6JLhiejyhHzswRgY4RUfQSIsGtpjC2Hbx4pXuXQwo7KdPtOh9QMrtv/cFUumYTymHDc6bSwcTbRF4vrOc/jkloM2GfN3ioyYe7+G0EzdiHfAbhWCN4H6xm2TGHNlpphv2LN5sJY4feCRI+OdPYrqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800867; c=relaxed/simple;
	bh=EY0gY/mYWjkbDIJfbNJ2HQGjwHWyLFvQfujYiQs4CyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DCmvo3zozI2IKLI8JksGFmTJe4OZPUUzQlo83y/cl6zIuqPrAUsJpiCKxRru/APgr7E9i00H7cf40dkQhzCn00zPLfjVdiBTwMTon1pxrbFMbtF0sYFkbSKcSnTPdeIaJDny0hw6uxGvvlCRrJOh1Dd8V88BlssRRdKKQIJkKG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2eb9ae80so1451875b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755800864; x=1756405664;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EY0gY/mYWjkbDIJfbNJ2HQGjwHWyLFvQfujYiQs4CyM=;
        b=ig1DzSuJM+2z3ud77L38EAWbyfRWOjWtaTbkJZw0LYNJUPdgh+UGpqtyUZ3yuTALu+
         3UW+E4u7U0tgtxngZML+zaWLuFOdqWsej/cBLbHMOpGZrtDZ/qSqGDiOvj15I+FOSyCy
         zXKdf5frjeEE+jJklNwtnCYv2422BlaW6J8yP5VTiTjN2LpyMtCA9MIvjgqJ3bql8+6j
         yCtXl3vei/H1RiD9pKEuNcgfV8+KNZE63RweXIzMXh1paQg2A7irO6zPL8JVlcSPydUl
         LWhAXfL1CSoA4WbEDvEmZ6Bhm8+I2LUBF1fQMufHqeVq6FWhRIH+ewM/BlcYx20glOTX
         f/jg==
X-Forwarded-Encrypted: i=1; AJvYcCW7neG1NL/OpD6pzhaU0GJjJo+IqoL3EV+GUulP2J+aJYb6vsf1gngkaNiaZIQgHA6XFBPIfM54o4uZkVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQWzk3LmI6H5fX45l8iOiKB96P/5vmjKGWApW/4r5zcm48eJ57
	sTKsiNZQ/E4h/xWps+QxShKAxyuZq82Z0iqqJ9bVeSNgqMT6jIzDZYnOeYvMWqU7MoU=
X-Gm-Gg: ASbGnctOxgJYJnkU2l3ALLZ0xCSBdXPFswU0akZuZpnLsv2VbpaXR06h3TEjGXu8EYc
	AMteNuXkcMB0G1UDaTWCRm//dxsDOE2klTjhbfay+GvYUE14yoGwCSIA8JtL2dbVNRYsB6idx6o
	qEQcGLg8uwRAIwQi8l/QpHrvohJm2PANrg4gFhz0jnR1H873WcRzw3mralPCuQlG9rR8F2TlUNQ
	+eS5sbru+ieYfJtOjIKMUZpv4AW8o34F70q6Je1c/SdaR444TsoNziny2u0MxXY/QQhJglWrfjn
	p4PhkW09+esoouLkP5m9DQuC3MbBIKTQJC7Q1E77LycCiICfleduSiWcGkpspHNJJjQeaRvH09A
	/VCF3bC0XpWbEBIIDe5gG3sYwm2JDT2Q=
X-Google-Smtp-Source: AGHT+IEfpImoo2zYBpYt2BN1pDYojgLhRO7Rhajj0yKSOBhITg9cGOeeQi2GsaQb0mQqp5FnSKDG/A==
X-Received: by 2002:a05:6a21:328d:b0:23d:ac50:3339 with SMTP id adf61e73a8af0-24340d2c073mr175396637.29.1755800864449;
        Thu, 21 Aug 2025 11:27:44 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe3287sm5319640a12.15.2025.08.21.11.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:27:43 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Beleswar Padhi <b-padhi@ti.com>, linux@armlinux.org.uk, arnd@arndb.de
Cc: krzk@kernel.org, afd@ti.com, u-kumar1@ti.com, praneeth@ti.com,
 b-padhi@ti.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm: multi_v7_defconfig: Enable more OMAP related
 configs
In-Reply-To: <20250819101137.2878336-1-b-padhi@ti.com>
References: <20250819101137.2878336-1-b-padhi@ti.com>
Date: Thu, 21 Aug 2025 11:27:43 -0700
Message-ID: <7hy0rc4jj4.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Beleswar Padhi <b-padhi@ti.com> writes:

> This allows us to enable various peripherals in the TI OMAP family
> platforms like AM571X-IDK, AM572X-IDK, AM574X-IDK, AM57XX-BEAGLE-X15,
> AM57XX-EVM using the multi_v7_defconfig, instead of only with the
> OMAP specific defconfigs.
>
> DRM_PANEL_OSD_OSD101T2587_53TS:
> Enables OSD LCD panel support used in AM57XX evaluation modules.
>
> SPI_TI_QSPI:
> Enables TI's QSPI master controller driver for accessing flash devices
> on OMAP5 platforms.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>

Boot tested on am437x-gp-evm and am57xx-beagle-x15

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin

