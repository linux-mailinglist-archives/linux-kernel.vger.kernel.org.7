Return-Path: <linux-kernel+bounces-849831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C768CBD1070
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E291893B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11CF214204;
	Mon, 13 Oct 2025 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byjPXSG5"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60751FF1C7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317306; cv=none; b=k2YJeiE5NyCj2gMnqX8xA2ZSLP8LMjSOlnk6Aj1UKreylvGNS7Yovz3NKYuFMeuI74tu2j1GEg5ljF6d7jIW/uovBiqDI4Cck3n7qPViAenoJDHu+8eLY+JwwrdWXuivoVXX5uroMCqig6qxchZGNB8bV/xl2mOJRhLMd1lZMYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317306; c=relaxed/simple;
	bh=Q0pn8oeo+EcdQqzzyFQGfHXmr2LXraohVV8PKC0lDGU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oSvxjSCzRBMKFs3u0eWBO2pYmmr0YBxzQT4Y8peAcC23u4VjmtBZVrfvjkbaIDnqK0uyh8uvyS4SPc9lpCkKiOjrxzvKi7hDx/IInNNBLcn9rJB6VOM/KN9m+WbQC1hrdZq98ccDKAzFmQzIEIho33KVs840oIducJeEcvJ9ZFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=byjPXSG5; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b63e5da0fdeso250762a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760317304; x=1760922104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPXC6v/EI3bevjgCYFAPjzae6a+9JFnCELYN3lWtwW8=;
        b=byjPXSG5DmeyBXjGLF9BmBwYji18r8Y1BYQsWCY0sTULTGJbpnfsH1rXH30Wp8nARs
         AHrhVk9XZI+bYGIIJzaao3fljaYo8P19baeQVbkRGsfORD1evZNr4x/ssvjnEe0yT0Ig
         DC+1oDU5HWfmxJX62cQhJeq+4l+tpCRq/u7CF2HU3X1y0Y1vTIZcKUKmqAbX2MVxSyZn
         XO71bngpNP6ha9GcbJpzPZCou9rVklghvg7uFYbKQYTkuPsoe33CocP/QHBzISamkHNV
         sYAwQDMM13nO4WWT/0vWpneUnJ24yjtQM3+qYwXNbs8a1E/Un5WupzlyG1gY2uMHy141
         FPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760317304; x=1760922104;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPXC6v/EI3bevjgCYFAPjzae6a+9JFnCELYN3lWtwW8=;
        b=fjDBtDchljGe/+G/PydwrziSH5ZyqblwhcoQ+wF9Vgc0DhlnGgLJe7XrjpujYv99D6
         TzJW7/CHE5LssXaEPjMcJqBITc/SULE2WNzX2ZPYHGyP8ooMatT9VW5KFB9XuUfhU5is
         nuu0FtJbRTMLUZizZkFWhUu/Pr3XmQ6og6ygHRVzq7JrAOdNmOa8WoyuYyoRgC4qK3A9
         KVeqYLsA8FBEbM+bV1No0SLW9mqMC8KlTT4ACn1IlDmlQumlYgLVI6sWCdAFDtrQOJ3j
         EgYCfbL/3wIvJzNAT2a8uXdN4CsbVcGckg36BgIzC7H97tvV6FN3N4e92FronEciLcZZ
         XYfg==
X-Forwarded-Encrypted: i=1; AJvYcCWLxomYgOTZ2nSOJgC9YXLfkoZK5NtjHhjEPQm+qGwg4RYzOGh8d2Vp7DBjZ0OdcBb5+/MN1788iPRweD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYRJXpHiWmEDISOIdsShR2tO9mf+qIYkjvuQrUyQ+RIZ3EzLI
	m1GICKehmvztMje5hODvSOAwisUX3flZTcULzkrQ32G+hJTqKsIk1U8a7IqBvqq77/M=
X-Gm-Gg: ASbGnctZsc5ArZ0iLZVrK++cbIcrTOy7WVv79VPiOiqJXcn+NZNh5dsWR4x0N8fta/9
	U4lui5TUTNJdiUksZrrZ6xvV8tsF6DTM4bkoASKOTnRKJr/vty77ozcssTTAIx5oSf2K148/sGs
	K5Xy7S9HLMLKf9T1IKzwkkWvjSCUAR/36AUGOjwBnSMu/29Dob5uylRZfEkXM7/NADSKkEtVjkv
	oYu5v9vbfuhme1vesim1XkkezCqMAN5UdQHjShaw6vXgiNb4KrCPwnWwP0CQH79P7hmN4ATJoUp
	tryX47y09QFvxT9B8CKt4u+YwC2xU8El0QoTxW/BU24soFqc48uvEu6M1lLkSduPQ4qA5nihkHz
	G6AWmUomON1G30cqEw74pFXQS5k2Hx+DoI4s30C1QKKOkTCwCxU4UKljM33bA
X-Google-Smtp-Source: AGHT+IHGK6ykX0spOQKYWsRpuS2oCY34wte5d1qjAZUxv5DNXPyTnvUCU5Jclrwq6RaUGeZTRY3rkQ==
X-Received: by 2002:a05:6a00:cd1:b0:776:165d:e0df with SMTP id d2e1a72fcca58-793827947fdmr11943201b3a.0.1760317303940;
        Sun, 12 Oct 2025 18:01:43 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2ab3sm9512805b3a.64.2025.10.12.18.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:01:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com, 
 alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 robh@kernel.org, conor+dt@kernel.org, sunyeal.hong@samsung.com, 
 shin.son@samsung.com, Raghav Sharma <raghav.s@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, chandan.vn@samsung.com, 
 dev.tailor@samsung.com, karthik.sun@samsung.com
In-Reply-To: <20250915095401.3699849-3-raghav.s@samsung.com>
References: <20250915095401.3699849-1-raghav.s@samsung.com>
 <CGME20250915094515epcas5p3210f5c66a24a7a7f23a04075e7636a89@epcas5p3.samsung.com>
 <20250915095401.3699849-3-raghav.s@samsung.com>
Subject: Re: (subset) [PATCH v2 2/3] clk: samsung: exynosautov920: add
 clock support
Message-Id: <176031729821.32330.18319569352723802430.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 03:01:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 15 Sep 2025 15:24:00 +0530, Raghav Sharma wrote:
> Add support for CMU_M2M which provides clocks to M2M block, and
> register the required compatible and cmu_info for the same.
> 
> 

Applied, thanks!

[2/3] clk: samsung: exynosautov920: add clock support
      https://git.kernel.org/krzk/linux/c/ac5d829873c737edae220ee654e423d383163630

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


