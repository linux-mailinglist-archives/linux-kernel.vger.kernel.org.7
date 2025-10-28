Return-Path: <linux-kernel+bounces-874112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0A7C15916
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2452E5843E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E000634321D;
	Tue, 28 Oct 2025 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9UfqnBS"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4DF342141
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665814; cv=none; b=Se9AtcvaLP+moXIP5YOfAcovpIWVCvEIdNHxTVKcxoStYpqDZUocJapC3QOUvuZi/m+CShaz6jVa9FnSdi567cVr9WzICnmMLsizYBLarb3LmHpQqyX5t7haZVNQjhZ4Eu3EQcGboAKrPD54YJoQ3wwC0CeGYsyIovM13h8CcQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665814; c=relaxed/simple;
	bh=bRHCOkh4N5PCb53quDW9/VegPwopMuUXUgLMaF1jWbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LByoeIYv1013GzpSSZOmaCNoe/oJVUiZslTZtHWG6tBo/AmQoVAB5qDqwz1IqzukgLhP1n7as/l1ND23hws6cmmQI1fziII5WHFb8WghXVoO0OzedJHQhOLYX8F+8SLn97eEL1KC0iBsolrefgluOxpcQ0GjsJmLdOlTF9v/+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9UfqnBS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso25975315e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761665810; x=1762270610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRHCOkh4N5PCb53quDW9/VegPwopMuUXUgLMaF1jWbo=;
        b=g9UfqnBSN0rNsPCMkSQE3hRKe6HubhK3jeudcp7j65DqLDBY+2nLQDpWVPXRf2oDqd
         Fs7EIhEzc3OyTsxQPvi+jwg2NKRfk1TH0EsjhRyWP53hxHthtm4FlI7uY8CWkh5bfQuX
         Rfi9/bwAom/mZ/REz/MCV4awhfEdZuQd2j1l5LjJHhSMvkLzOtFeixOIUnizaxclv7De
         P9TXfrB1E9YLNNbGXAXw9SQt7CgodlRVB7PsbtZBWsitqHRzYNOqhSfDXIh0yNTOuBfI
         0n0WChaPUrNw2bafpGlixtoB19MC3JfwltHVP4S1Iga9ml6pXtq0BnZdmkkNjSFaMIRd
         q+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761665810; x=1762270610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRHCOkh4N5PCb53quDW9/VegPwopMuUXUgLMaF1jWbo=;
        b=F5XogU7JYEImKk9iDp4pIz7YjSW7khFzyz24ZPfwvPTXq9nmAetmMa6JuJro0oqOfO
         wstfQJ6zcudCrF5gvbrKqZDbB92GkDbPuxDeTh6ppGn5FQ/AWPqv2YBxuFvp66dBqUXz
         ZCNbljplcZeLGonr5ZN3NYPKxEkakJv9p6wgJ0Bw9vLmdPf/ljYES0J3Np6UFwa8oKRk
         VuMIhVWME1xwshgIJJJsWC9tpumPGz0He0IJag4GrsBj7syAiRKGzhpnvzqT0hulsVrK
         8M0lgOk7AnVWdJtTxc6xWBwD8l4J16rzo4aNLI/Km7cB6N2oZOxAR9eAya4JE41i7Tkq
         JBpA==
X-Forwarded-Encrypted: i=1; AJvYcCUW/s2Cx1OprD4L3fF3Z9CJl8a9kImzfNxY9qw8Pn1uywd8cebXPZKDLDgAHqbROQG3vT/tyz4c0QAA7Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNAtLsIkyjNvmzfd0niU4WB4+dSUIqrBmnP4S4nqNxMI+8sUm/
	T/Q34JS3eAvb5NK8ZpTh7MtcsR8lfavAWS169IqCLl4g0mwrlT5XA/eV
X-Gm-Gg: ASbGncsP14r56dQQ4Fcj39dk/YcXWJdgnrMrHTLZz3YIBf3Ectv8eRS7ehU3bMwYawe
	rJrQeUuUbapoaupocgvv0zBvBzk20w5JcogZ61AkHyM+VF2fIoNOl9m1wCaQMHXeSvZVbQ/jV09
	kyBKztNOlQgNBGFpJhPoHjdivf54YKbXVle1wwBKAgonFSbQa0hheN1VUw/ammpnSIOj0Afvm07
	1w/J4hBFwJJLqJvOU+vZz9FpNwJoVD4MQzKeW5YUeOgE3mfPNSRJlRPd7njlnKOCA+vfJviIF1D
	JBGB7r4f6NqWHzIAcYALTErJLWtwH80brkqSJjvvaCE7BPT6FSgBbgLToqCCH2SX/GeacGfRJ9C
	WE2m4nlkwJNh9K3vVJfNkAzU80U1a07YeplgT2GjuFH/zZGJpfILhpT8wFVnQmB1VhmMi9f/W94
	YraAWY4cBdnNSm+IbZbjhsljR+yVsGEwSPt7YqENdDRbV8oAkKwsyfOgsWyA==
X-Google-Smtp-Source: AGHT+IHcEqxrDGNbCr9Qf3fhYUvlJSJPyM3H2iUm9WQHT2tvvW1arfoNj1Bg06ZOGX1vRi4tbPm82Q==
X-Received: by 2002:a05:600c:8216:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47717e30970mr33449425e9.26.1761665810438;
        Tue, 28 Oct 2025 08:36:50 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd374e41sm202105775e9.12.2025.10.28.08.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:36:50 -0700 (PDT)
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
 Re: [PATCH v4 05/16] mtd: rawnand: sunxi: introduce reg_ecc_err_cnt in
 sunxi_nfc_caps
Date: Tue, 28 Oct 2025 16:36:48 +0100
Message-ID: <7866116.EvYhyI6sBW@jernej-laptop>
In-Reply-To: <20251028073534.526992-6-richard.genoud@bootlin.com>
References:
 <20251028073534.526992-1-richard.genoud@bootlin.com>
 <20251028073534.526992-6-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 28. oktober 2025 ob 08:34:58 Srednjeevropski standardni =C4=8Das=
 je Richard Genoud napisal(a):
> The H6/H616 ECC_ERR_CNT register is not at the same offset as the
> A10/A23 one, so move its offset into sunxi_nfc_caps
>=20
> No functional change.
>=20
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



