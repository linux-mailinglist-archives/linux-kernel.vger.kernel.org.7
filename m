Return-Path: <linux-kernel+bounces-838220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566CABAEB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 00:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DDD3B9AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A8D2D1931;
	Tue, 30 Sep 2025 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3K9R98n"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E519D087
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759272939; cv=none; b=P9mnrqJTkHHEefu0B9WdkDLhL40vHIeyPEXZgU2Ib0xfC6I87pXzmqC6eqBADNjhDAJn6RJNF9LHAt/TUm1m1NfonAjy5/Nduk7aL9BN8CyA6N8ob54GzS2k7qz7c6jyZ/rlpUjgogCf1naM6fsS6MCd/MQlqnyLjRgkhiFHD+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759272939; c=relaxed/simple;
	bh=yVA9Jz0NaEGwNdHklt155W5PzrBW3E/ulBCRYzSYVKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C22PD2lb+UICqfMT2k5eN97ijcBxnTmlZMZHWE4/dL0rltDsGGnAHQovWTUfYku9S2SJJsx2qN1jVymrFnSBdynz/9YxQuwlWY+VErfoYRVgK3EbUFWYm6bf0uGi17oMObPqmYv1LO5t2bXcR0b2keWeCwDYmEwKZzMkV8Owf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3K9R98n; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-421851bca51so1654314f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759272937; x=1759877737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yVA9Jz0NaEGwNdHklt155W5PzrBW3E/ulBCRYzSYVKM=;
        b=N3K9R98nxGxOF7OnWp7haHEZxY0ov7TQ9GKSMdYDU2gI/juQyD3zvWoHQ1utwBq1f9
         GrzMcfiOmQn0D7Mmj5ymg+alkn/QqL6AKSMo7gAQvsg21RYlcc72VZRuQ43yMmrHfzSY
         8coKBMDv4HpD7EOemzjWVlHT0gADklB+Fa/gMYphsUDatGFNIoDnWroUcP74Zr3Jm0hU
         weT9qkNVyFo/TA98OQDPx2z31TgaF95c4OI0DGxjY7lx3uX8WlyQItJYYESh0mSVm5x8
         zpCiye6Fv4oyNMdNxESSpW2YW0QRbWZ+oGwfTJKKLnUPJr3vRFsdAesiXeUBlVlzAYX4
         8zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759272937; x=1759877737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVA9Jz0NaEGwNdHklt155W5PzrBW3E/ulBCRYzSYVKM=;
        b=QgRNaHf5f5wlMqfyRdzFcAjcnkYf9S5z4f8WzD/yNngDQ1WDLWwVEWQ7r0yIou/b9A
         mQul7POemjfnapavioNXdfXGNF5iVMS0YeNt7yOAeaGxtAWTrCZ717i7Ic0npa5ynf2L
         jmya1qNoT3dzgAhENKKuDA2zHC1UdtbsVadRvbiYt2onkuzyVb2tirOGZ4ZG2FsXYgd6
         0vqUMDsvKjUeaMfVOVdo3TRZa8DVfRFc8MgSPr3G4np5RQDRFyDIGMezq8gRYaV5WE56
         fDbKraOACURfCLHxl1uSvcb91dydcaKcWlofonr0sh/+L1vrG8FXCmoU9UYY+qHB7hHX
         WjJw==
X-Forwarded-Encrypted: i=1; AJvYcCWCYxb4a3v1liP37EeXJAWobeUYDm3bh+TyccPNxu4rmpQy29S6X7ADgUKqITondQiAUbz21DehZhoFCkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW8nO65443GPMhK+Nal3VW1Wb7uds1pAQ65XZyxRVErEFG7G9y
	qjjsw/mnIV2jvpXlGjIJes3TE5l5Q0RUQ9cN2qg/QEdDQFX5TI53SPXaa4ZqRbQb7Hgpkijp/z0
	/jfGAezvrNDg+09CXbZIWuUWV1gRwqALe2O3s55BF
X-Gm-Gg: ASbGnctNhSE4+Xh8TNwV6/AhWaoUpNNeaYghHQQMjXiidtB27kiVpuiiwKZ5Q10qCo7
	E+Mln/QCaGbj2r6+cakXj1FA1soOEnsc3FfsPPoUFaiQr/Ttm3TQRwrsrsNItx78DOSKmMBEgOe
	Td0T8WnU+iqeRSe1JjAXjkGcR8KlaSUccFp164mybCSrkkjjY5wgWF8XXaY6PkTvCbvQG4tADHF
	EYvkYfIi0x+5fD3w61MZNbrcvGxg8YCxieNWvjur6WKyfRISmuvG7mGAX1RFv21Op6oZ8/UyfTM
	OPLc9jWt35FLVw==
X-Google-Smtp-Source: AGHT+IGHRuxtWgut0Vzt6PdinBJDWxg9G0yj04Jszjbv4ItQ3wbJzXeBdiQBzEdeuLcKh8ZuTRqv06sC4HCq3f+U5jQ=
X-Received: by 2002:a05:6000:420a:b0:3ee:114f:f89f with SMTP id
 ffacd0b85a97d-425577f1bf9mr975463f8f.15.1759272936532; Tue, 30 Sep 2025
 15:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930012352.413066-1-jthies@google.com> <20250930012352.413066-2-jthies@google.com>
 <175920697975.1402374.5817792319376446761.robh@kernel.org>
In-Reply-To: <175920697975.1402374.5817792319376446761.robh@kernel.org>
From: Jameson Thies <jthies@google.com>
Date: Tue, 30 Sep 2025 15:55:24 -0700
X-Gm-Features: AS18NWBGGK3TvBvWwAKJGudm0q5uvJFaU-KF4NSgxPec6eL4jZqolX0Co6k50AA
Message-ID: <CAMFSAReZA3=VH+c2H3xA-ojhBnEEp8wxySFwUuKLq+6k47AA4g@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: chrome: Add Cros EC UCSI driver
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, bleung@chromium.org, 
	heikki.krogerus@linux.intel.com, ukaszb@chromium.org, 
	linux-usb@vger.kernel.org, akuchynski@chromium.org, tzungbi@kernel.org, 
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org, abhishekpandit@chromium.org, 
	chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> My bot found errors running 'make dt_binding_check' on your patch:

Thanks for catching this. I did run "make dt_binding_check
DT_SCHEMA_FILES=google,cros-ec-ucsi.yaml" to check the newly added
yaml file. But I didn't check google,cros-ec.yaml or any of the DTS
files with "make dtbs_check" so I missed this regression. I'll follow
up with a v2 series and test all bindings with "make dt_binding_check"
and "make dtbs_check".

