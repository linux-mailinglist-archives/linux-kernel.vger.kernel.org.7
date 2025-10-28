Return-Path: <linux-kernel+bounces-874137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A23C159AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B43650147F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6C33469F5;
	Tue, 28 Oct 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDl5YH+/"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278734678A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666310; cv=none; b=lwK2hMNzJILzfKvE0mZFglDHM38aBn5f/0nlWttBD9+SJa/dsw7I7aWzaD3QEiGjNpm5tX7Flh2MTKUoDmApd0rq7VzLArDAXPRdC9HCT+HOhi0pS5hC134Ho6p4lCzdE08SWCjQEac2pwSAZ87eH/Nn2ieLQ9VutfDMq27Gdyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666310; c=relaxed/simple;
	bh=GAqSgVsTThU3vtmlukZG8xLx1H3wk+zWeretWdrZ53k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLa0cRtADSAKmDgaGSC6LeTBKUmHi/M+Sju5VYtSdP4WXZSWkpRWX/CnqGk4w0QyXyaXZhxmif9JUw9bMEuqx1EXY/uMYKEwvV8GqvEQgI/1f3XBzKG6L1eSkEG0kCwrgxk7fTihUlhtSqxIwLfF0DrAzc4iX3sqUWFvemYO3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDl5YH+/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47117f92e32so56114815e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761666307; x=1762271107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAqSgVsTThU3vtmlukZG8xLx1H3wk+zWeretWdrZ53k=;
        b=WDl5YH+/pbuValcQE1Sr+SxsHz6ZU/VU4R9tLGeuIUaILWa8+NDKxuTGIreIyzqBiD
         0XPg2pPhpCaLEN/f8Scf9NUUcFBekB6qJk61LKr8T1FRoqmecGFSFzh8z/RsT375jita
         /uuN6gQJCaO3CCn3EQS/Ka5mbx3j15df/bnBySsQ779EcslSs8fzCDnZit+2hwW4nWEo
         ez034qVGwslYFtqyAQfVth0X0yr2nW4swX0SWwbWe9cY/8AXRgAVZ5DFWstZyrQgg9LS
         3Ve77jQpVL0oaM514ysm2AfYzjdncFkF6SFK0JlxTm1qTqCdBCkyQnsoT3xEZHuQMaFh
         8Dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666307; x=1762271107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAqSgVsTThU3vtmlukZG8xLx1H3wk+zWeretWdrZ53k=;
        b=J4SMPCsTcuiHzBQ7p8fhBzVp06U/cYokDuQRK1bWBbiCLb0qfiLXyfBcmulXXnelmc
         KY7gAoYqE06MrFvyNchbzSVcxxezPk8B9yh4iAavmQUgrZtk6GsvjCIYW/vCfAKSA/y1
         O+rZ4bZ+lUYpAcu7boLRJ/pDSGjT2fLG5/iQ8Y5M0EeAqtvRxGBvJPK+xy9HjrZqz9Mg
         1b7QSjq6/iDvYmvkDRCvds4ZT/5JTZdRT5M2NH66XIiLC3cAjmix3nOautrsuLZUfNst
         ujaiYAEa8cM/0IdgVHPe8SUXb3dWdxtglmDRchVzg1unYsaH7/Ag9lpeo+8d55JZhciz
         dsng==
X-Forwarded-Encrypted: i=1; AJvYcCUzP5jxV8vXS9w0QPN7LZHk18lxRncQTB4gqGzmsxZW9+4OrudiubQTDdRUVQbj856DBlqPvJtZMe2zhP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySo7tq69DcJWofjoPpHmLNS2Okhi4yILWsGRXCGRHQNuZW4VOB
	joI2A9wkMZKRtduNX4JkGqCtbDC608rg2zedyV+wcAzMvPkqOcdejXN+
X-Gm-Gg: ASbGncvHYeJz4K0RiRjac4Fl5j77NB1zK8+DzrqYw1F6OkG06VdyY4ChB9/xwxaAAMU
	W0vb+4HcBNE/R6RQQGmYRGr4o26RL3qpbVL+Q3Z6/DKC2hJP/rqluvpJm99+IpXlOvQ10Ms5x1I
	cMulyR9RPZ183wqNqUm+YxGxE2NoUgOIi6UcTFNlxjWSrd4l3wSNxCscYjQfvJV6frpM9leSpow
	tOlhBXFBGmQnheIv7XejM2Frcp6B+3PoQjrPmP8IPCoK0xxaxtTbqezaiMO72zcjeLkDCqwm6pJ
	TXyrUirMugKGgNoNiXr9DD+omZU1PrK39SXwR4TwsGnrEuos0WgkeL3Ldmc97RZTV8sNSrl2OM2
	C+3d++G+j0GInxmKK+yP3Q8QE01i7/o7XuecfJkvGNbuav0XzqZYqDAUJBHiw9+DYVOubuTA8mq
	stEzieqiq+erapFd3+NWEZ79NjCdKYHgjSr3hOgPMQm4gV69eJNXNbQZ3jPg==
X-Google-Smtp-Source: AGHT+IHar4ykqVMzVnQnpMNRdCULBt0TW79PeUZzYouW3L2ifb97HosTgMs4SMM16AylRCMZ0rMIQA==
X-Received: by 2002:a05:6000:1862:b0:428:3ef4:9a10 with SMTP id ffacd0b85a97d-429a7e8500cmr3696482f8f.54.1761666306579;
        Tue, 28 Oct 2025 08:45:06 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952ca569sm20562147f8f.12.2025.10.28.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:45:06 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Wentao Liang <vulab@iscas.ac.cn>, Johan Hovold <johan@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@bootlin.com>
Subject:
 Re: [PATCH v4 11/16] mtd: rawnand: sunxi: introduce reg_pat_id in
 sunxi_nfc_caps
Date: Tue, 28 Oct 2025 16:45:04 +0100
Message-ID: <3574896.QJadu78ljV@jernej-laptop>
In-Reply-To: <20251028073534.526992-12-richard.genoud@bootlin.com>
References:
 <20251028073534.526992-1-richard.genoud@bootlin.com>
 <20251028073534.526992-12-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 28. oktober 2025 ob 08:35:04 Srednjeevropski standardni =C4=8Das=
 je Richard Genoud napisal(a):
> The H6/H616 pattern ID register is not at the same offset as the
> A10/A23 one, so move its offset into sunxi_nfc_caps.
>=20
> No functional change.
>=20
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



