Return-Path: <linux-kernel+bounces-849815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C28BD0FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA09E4E7CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 00:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2CF12FF69;
	Mon, 13 Oct 2025 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjRSj86W"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C601A238C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760314795; cv=none; b=YXTFdnq/cKH/ljKOdRoj5W9zFHF04DYo6oikA1NuhCC+b81RaDBxRRp9gUU7exWBoiUDQDTT9F2uvCRvQuD3tZHX4lzSleej5ZYHZzsoLek46+phUqeiXAp232njFudtkdffZFra+IZgf7agKv91if01l/zIC9nmnwk4ulkVEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760314795; c=relaxed/simple;
	bh=SV+DunIzUVTWBJ78hxKCfUSi2AinILUQvteKhxogjfQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bp/t/fwep9GPyXIkgWFUMIYtqwxvHpdSmdlRw8494pn6+3z03akRC57FD5H0ZXiG56BVa66KCmc1KlV/cJhdelWHGHjmpIdBNehIMg4Ae3TrFSaLwYLZ1Pdmk9GJsIjZOzqTLIGeRT9nXBHSmGhy3n/yI46iUAHIdFkr3fGjc/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IjRSj86W; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33257e0fb88so414152a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760314792; x=1760919592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ6yp3ug3gp30Xy0Uek/d5n0xvfYuEykldX/ZWgCn2g=;
        b=IjRSj86WJBpp4yAV/Aujhr9g+cZU4jJvPIFSW+zrT+1pBzXknK4Y7xhdQmsAJped5f
         LWFseisKttrkoGxvYmGQd5i68oZZFGPuo9A0uBUsXVDd37FQMumuLphFkqSBpp0cTG6R
         uueUJ9A4MuB7zVk8/WjJ74Z/Q2XcvKujRrwfPVulXgb+3Vxdk522Qkw32qTBYA6HDNz0
         ixCN4Fbq/Ngn8c/rvcVM1Fql8RFTImbSObKosx8wCVfaSzo6bscRDF24SaEoNb/6nf1u
         APUsv4JeNaeeNDVJ/OE0QmiprRDu6WtgLOnSAHU4df9FpIIb/B7OJiaPAc2kU1o8zRpt
         jJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760314792; x=1760919592;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ6yp3ug3gp30Xy0Uek/d5n0xvfYuEykldX/ZWgCn2g=;
        b=oTV3D3w7E3wSY9aA72AC6KQu5vl4yaGxpRaDRVFfOHtPNJxy8yKBJRG0g6pjFs7uH1
         ssL38Qc2QK30xwFzEYK6yUNpOboILbP5+C5y/bwVExDt+r6ayOBxEHrEbhwlaoM2nXEW
         HoyFMf9hEUOrTD1TFXtV9yWSsexJ6Z5LpjKMhNqxhmkMhD8mS0iOshbKP8qLog67EJCD
         haWp9bcfgq+MRnZQORCDlNzxOxJBJjjTM4Gjp+P1XZeugem6FYdzC36gP+p9M97Anv2Y
         gE3kb8/Ko1LKDvlc+l2lMX3sNVHEkWh1XF2RFTFIsU+13SzsXyLC7SaADNfJDVM3G1en
         sevw==
X-Forwarded-Encrypted: i=1; AJvYcCVJCBQbLUSRtnN0Lvm90S6ZfcWRoNM9bZYRSsve7zUoVHa/c1DtioOkr+OND9LBXy9leaUdCaahpJ8rY4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlLLFDBxT2zXNPQhxetZuQETgmQsEckwuRQ1P19fQnmUxqqpPh
	NNxteeYAiNHZSw4H5tXyiO0XVTYmIbKK2CHrW2l4tCx+urUrQ+m6LFevWsrI+MYd09s=
X-Gm-Gg: ASbGncvBhYuXfjYeM8m0zs1nw9fUD0xucfSOe48BHz2xlZvKhAwAtLSPq3guCHYI7LH
	W3hoABFX+ZnMmdFQo1ipHkIYJRxAjxcI18Sr91YT2QMwGwnpcRLZzp9EbI1LU5IPVBNfe5MgsQw
	LhZhnB8p48JubV9R4z3pEaRp7xzvzmjLybRgusQApU4rM96aReoSbVkqsp1MCytq5JuVrlGgBLL
	DbYN0tSQP6dQZJackqAo8rgK/E9ci0z3sgO/hF7N7staajlUy1RCWW8DcKzTI+B6ukLXLI1htZf
	2A9Nc0pnFu6vwsRzRHRhesvjq+PWiFwjyivthfLKNcZYzRF59j+8V0q9Vs/eDa5XQMsmMrWve1q
	oJPYieD6o3dk1HQLezwOgxI1+km360KSlq54vmvLKZnHOIU6G+v9m+LoGzI1s
X-Google-Smtp-Source: AGHT+IGjjx1VNGnCpiP5A3vgujtOdzuqPcwtN4vHp0jbvJabv/xK4Ctc4Ykk0OUHsRtI9e0/wZ3Nig==
X-Received: by 2002:a17:90b:1c0d:b0:330:7a07:edb5 with SMTP id 98e67ed59e1d1-33b511172b2mr13409830a91.2.1760314791938;
        Sun, 12 Oct 2025 17:19:51 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b62645851sm9679057a91.9.2025.10.12.17.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 17:19:51 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, zhangheng <zhangheng@kylinos.cn>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251009174519.393898-1-thorsten.blum@linux.dev>
References: <20251009174519.393898-1-thorsten.blum@linux.dev>
Subject: Re: [PATCH] w1: ds28e17: Replace deprecated strcpy + strcat in
 w1_f19_add_slave
Message-Id: <176031478797.9069.13007324007524782504.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 02:19:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 09 Oct 2025 19:45:12 +0200, Thorsten Blum wrote:
> strcpy() is deprecated and using strcat() is discouraged. Replace them with
> scnprintf().  No functional changes.
> 
> 

Applied, thanks!

[1/1] w1: ds28e17: Replace deprecated strcpy + strcat in w1_f19_add_slave
      https://git.kernel.org/krzk/linux-w1/c/f3c6353d801a9826e234ad477af08b09a98d888b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


