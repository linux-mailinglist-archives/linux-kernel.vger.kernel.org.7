Return-Path: <linux-kernel+bounces-862888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5984EBF6757
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42303BEA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD4132B99B;
	Tue, 21 Oct 2025 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnhackCI"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C154F32AAA8
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049788; cv=none; b=js3PHOqF3jAw++WQjOOY44IDPr0+yQ0eKqMF1MzYEnILWjh7d/TYLTnDHt+2icCxmy7qy5hSlVvcoeqZObVYPAzKYXmhKHE5DHWTtfpZ9kY6lWQnGv5ncIm6o/ImIMYTBQ2fmhGVmKS1f2ZPtQIOFHqUw2+Df8dnJqYPjPni+/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049788; c=relaxed/simple;
	bh=uGirs23txhAenKHXdCP7WExbbtewFPdCzpQHrSYHZmo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sz4aQba5Fcx0FR7UVy4FpgSLbRav+HXIdyv/6EullKVV0Zs9Hd/zSXNLt4Y4VJZnDwhEcoYA0+b1E+IXnn6pRQrp8dvenhSUGbnhJq9021WGf2p8ecktJwL/iKYnyMwxmaUhD6y+UsigJAht6QEvlA7EfQDLw1WU4Z7YwmPBNCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hnhackCI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso2532038f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761049785; x=1761654585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nw12B7KdWN/wbxxijDvUQZ5OrO1aWstBkEoWMIB2hXM=;
        b=hnhackCI8DWY/JOyDCX2YU4+rlT7U+7200sc30r5TwKxgoXeagKYMPvo5LgD7Z+qE6
         zrYLf9tWoePQny+CBxsTKXoebraDQYfieA8sS4au/UvKuptyBrXjdWE7DDybpcL/BqMc
         85gfMKRBESEFmPWA0EpVZ0jKzLnf+dFYHOH8FQ8VwICYRtLu1SFbpc7KBsKO8RTU7tzP
         wlwClJdoUieXQRhSgXOmBDcEAffIgb70u4MBGGFpu0Jr21MlZbka+jcz3lAwZJdx79G1
         n9KgFNuB0z2eOJ7ib++ubY5BTizH7plMIfo1yfmUZWassECQfQy3KdsvYR/NOUTjfxZH
         wYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049785; x=1761654585;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nw12B7KdWN/wbxxijDvUQZ5OrO1aWstBkEoWMIB2hXM=;
        b=wBp2MaeA3OY7KYTg+Kj/GJMWd2PloaFFCHjuz02lu5HLdl5NycKxKRYgpf86903q9/
         FcrzYWKKRbog4c3ekuVNU0+qaT6cZyVzOOFC3AsHiJ14vPVP5oyZH0szM3zowUkqadoW
         2mdL/pCuYlvq7OWQ2UQnszq8/fxue+8Y10VbxtGnWrvgRtUwhy1hOsPlkaq3kRK3YN+z
         aCqJNmjEEOmwPoS5738hj7u4/2+QTtE61RFa0bthsM5N9aTh6zlhB8gvKTMM/r37Fu0Q
         +tnc8zTukeJL6HSCm625Iv0QQB5O/0NGVkTIzKz2qm4/SfjEAyJvxk7iHUbbRTyIVI5r
         CjFw==
X-Forwarded-Encrypted: i=1; AJvYcCUf46V4AWVR5Kg7L4d8gSAgipeMY//l6586/9tE7XEaM/D8omEMomHY9ntUOgU3EwOr0m6ukfbcZk5v8bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxau3xBcds4gM9JbkS7kayUDsA6S/i+B3/xF1j9hEY1p0sHbfYL
	bShXU/gMV4MWLn2L8VLNfIC52M8c60Y2cDfCcjsc7fFeYRmNjm54Rwg0TdAvo8bNyts=
X-Gm-Gg: ASbGncu8nplh9NVTKpRELcmBbe7zKfFDm3hhLXaBE/+Q3RXLa/0TtfWdEXBIvynKSs4
	ir2U43y+pNrMoCwOrZO5JBPX685faTmW5VV+D0hkvlvjo2QKX7rLMwogGpLaJhGcYeITJv/PQ9O
	jmsYoUPlTPC2+La4owRS0CcW5KruMhHxmjly1vK7oo0O11hy/IAF2LFu4O5SXuq3G9jCZYuPbmq
	Oy8bgo3m57Ww0w3j5mTR01A6LsTTU0ZvgAxful26AvsxLTTHfezX6wUOvgM4060fuN6qJHYQg68
	gAAihIOz3OVFYLRJtPJPnAGcx86DhXBK3pR7m3p0T7cwei0qnbZvSSS65vZZPxXh/nGcRt2O/1F
	EtfokGklP8jaXutRx8qcF1rlpzeah73PvofFLXjatmxs/W3uHgIw81X7mYmOsxrLXm+IrqBoRR5
	9CLe4h0dcD+bMAPOvbcB2y2NYRtaaPJd4=
X-Google-Smtp-Source: AGHT+IGetap4T/Eh1Z+oljdXnfqlancpgAhNO6qspGOxItJqX1hECPXKuLsbg0/AZayCnBvDbJQ07A==
X-Received: by 2002:a05:6000:4a09:b0:427:62b:7f3 with SMTP id ffacd0b85a97d-427062b07f9mr13782919f8f.33.1761049785129;
        Tue, 21 Oct 2025 05:29:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3c34sm20057043f8f.17.2025.10.21.05.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:29:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20250927125006.824293-1-christianshewitt@gmail.com>
References: <20250927125006.824293-1-christianshewitt@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add support for Tanix
 TX9 Pro
Message-Id: <176104978445.3075289.8934335794181531302.b4-ty@linaro.org>
Date: Tue, 21 Oct 2025 14:29:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

Hi,

On Sat, 27 Sep 2025 12:50:05 +0000, Christian Hewitt wrote:
> The Oranth Tanix TX9 Pro is an Android STB using the Amlogic S912 chip
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.19/arm64-dt)

[1/2] dt-bindings: arm: amlogic: add support for Tanix TX9 Pro
      https://git.kernel.org/amlogic/c/beaea75ddc2a483e7b2b08a040d418f323510316
[2/2] arm64: dts: meson: add initial device-tree for Tanix TX9 Pro
      https://git.kernel.org/amlogic/c/afd1e16c6d3f53810ea29b5269dfcfc233e9b6b9

These changes has been applied on the intermediate git tree [1].

The v6.19/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


