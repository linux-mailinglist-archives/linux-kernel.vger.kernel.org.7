Return-Path: <linux-kernel+bounces-793365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F19AB3D26C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654F21744A0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1A5254AFF;
	Sun, 31 Aug 2025 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNaJ18bA"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C100E25742F
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637986; cv=none; b=CMXzsZBNCuCHQBlZesEhVIoDYzzbp/20DqXgDypHz5afbHsme/0pS4r1TX/InwsnTOGAoX/wNxF2KD3jhlBCrrznUPyWo2vmbz/vtxXEGdbw8JlcS5kOmyshojCS/Zcu5zZQmS3o/e8NkgJUhK4sIW4KES8ka1vKmRlF7mNgoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637986; c=relaxed/simple;
	bh=Btw22oIAGmU6sanSX9eSbU/bEcAdOnorrPnzQTd/6lI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H3rii+pqyUM55HmuRg3GSwyazCD9ZQo2+Qhld+9XAuiV3pAqNO1BorttsQlbBJPHwXq7o5yw3AwpoDrzaFC7bU/f/97FzQVjrfhyLankpPyfOMC0b8OY/I8rUeNqDNY+iJzT3ix1xbxODZyMFuGniwUSSMMWS/WLTMPEECvdFwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eNaJ18bA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61c78dc8b12so382935a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756637983; x=1757242783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUKJ0++TPvbkMoFrI+Y8BLlk2t3/W/jKbuvYaAm42bE=;
        b=eNaJ18bA/RVLPavPhBWRsCB1MH7PBajSwduYAL6wMw/QWVgGT/qJvYIbNpjkPxjQ+0
         aSV/rqYJRbpfwXh8Pumx6g7qbNZYp/YW5XulxLUqd5B0Pt6VxBoN7MPJJVUsrKsaorC/
         pYyh7QOhNILNey65IBqKGFAGhzPnwvwANoVnv/bNlrbbA+L/cuWpFcOmM5aeOC90SqsP
         iZBVnnXPZLjxDBw6Lsfajy4p76WT+JOkOueul6jN23nb29a1ba88j9UlXSJ4mfCxKvCg
         YTVBN1ssmW5vH/6XYw8/mKAzHVShDyQyu1Fsx4fQRCbs3Lm93/58GF2CqD1raSPz+/+p
         GiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756637983; x=1757242783;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUKJ0++TPvbkMoFrI+Y8BLlk2t3/W/jKbuvYaAm42bE=;
        b=tOdVH9nSjaIN3EoHgDnAjcEb6q7L0x5NN3E32t+dMDzYaZtUaf4igZ781dg8x/NRoS
         cnG85Hx5lKn2M37Zic9dUYz4T8LanQ0T2LLP7hca/jnSGrx9BFLjfvffJTquw9xovEh3
         sw2LX90tWNHj+UOAz2IBS716vKepoDIFoz+YZE9E7NUDdRUSTzKJCQfM8YOY+k2QgQQw
         f46eDqQrQkDTCDkwnoIoD8mu6LCkccowKxZBxvRRcwix0t44/1GKThmXD74u93p+Q9KE
         9u6qeYsQQ7+PlKWMRHatNrAnAG4X+bWlvJc6GqdnvFa5dSOkMJpNdJ2nngnO1S66Rwgd
         7ZSg==
X-Forwarded-Encrypted: i=1; AJvYcCWV/+FRKB5yn2ohh1IMhc8JSznYp8JsmxB+L9Mw2J1m7cx8RZ6ALz4VZAqqUoLqLxrF0ebggKb8KCMOAx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSAjVqzONrVK4mnWgxNYsXzFeiKFeWWmPDSppdntmF4571fCtP
	+7R7vc4y7fqt0erNU04d8xMhIDa0rNtWInCCkcZjDXzHNzCUv0UxHmkyIzTj90B2Jcw=
X-Gm-Gg: ASbGncua4vhpmBNfXRd0dBSjjqqxYjWdJJlY3A+R3SSAWlpH1azOYiOESbEph2vIQ1l
	7Z3Z8V6vxuuu+4tEXjBLLAZ8MNXWoZ9lVihJiQe9EugaX6Wv15soWC6g3rxnQ/J7pgkE86w2+GQ
	PUQkQ4xrzX8rHRU+2UxHJzZgJN2+J49qV/LqqCHZiP2VjzM7bvkPc3aIkq1boVgQ6huXXInwxuS
	z29HKOVYGsWhigJEUYNJAP31z6wkYgIO0M6gb9FP0hzMOisifrrcmPhLSZ0yquMEZ1EgrkDbN+p
	YeR1BtkmcLJtM0EviluXf9GgpZsonqTgr0TBEZPR151vrDF/4zb4l74O0Vrjey2a2RVUi5ziqI3
	o6ecSkO/g7UjJS6nD4XZhvzxDkdvxzkcn2y64Y7k=
X-Google-Smtp-Source: AGHT+IH/wnggLYJVXW/m3e9qKO69aqMTz3cVxphx9pE2l9/txvZNELvi65ntEkYfK+vEIC3B6xnNDw==
X-Received: by 2002:a17:906:c152:b0:afe:c2e7:3707 with SMTP id a640c23a62f3a-aff0ee1afcemr349705566b.4.1756637983020;
        Sun, 31 Aug 2025 03:59:43 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b041f00d4c2sm105452666b.97.2025.08.31.03.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 03:59:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250822133318.312232-3-krzysztof.kozlowski@linaro.org>
References: <20250822133318.312232-3-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] arm64: dts: socionext: uniphier-ld20: Add default
 PCI interrup controller address cells
Message-Id: <175663798171.36860.2362489342658881162.b4-ty@linaro.org>
Date: Sun, 31 Aug 2025 12:59:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 22 Aug 2025 15:33:19 +0200, Krzysztof Kozlowski wrote:
> Add missing address-cells 0 to the PCI interrupt node to silence W=1
> warning:
> 
>   uniphier-ld20.dtsi:941.4-944.29: Warning (interrupt_map): /soc@0/pcie@66000000:interrupt-map:
>     Missing property '#address-cells' in node /soc@0/pcie@66000000/legacy-interrupt-controller, using 0 as fallback
> 
> Value '0' is correct because:
> 1. GIC interrupt controller does not have children,
> 2. interrupt-map property (in PCI node) consists of five components and
>    the fourth component "parent unit address", which size is defined by
>    '#address-cells' of the node pointed to by the interrupt-parent
>    component, is not used (=0)
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: socionext: uniphier-ld20: Add default PCI interrup controller address cells
      https://git.kernel.org/krzk/linux-dt/c/613fb0c8bd49df4fb28bca89aa5363856487096f
[2/2] arm64: dts: socionext: uniphier-pxs3: Add default PCI interrup controller address cells
      https://git.kernel.org/krzk/linux-dt/c/a29bf0b10a1a7f51afb91c1ff9edd73b0ca1fd18

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


