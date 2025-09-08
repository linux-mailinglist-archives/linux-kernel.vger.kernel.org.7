Return-Path: <linux-kernel+bounces-805223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F179DB485A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583BA17FAB7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492AC2EAB60;
	Mon,  8 Sep 2025 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tqe1ZA6c"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0362E9746
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317069; cv=none; b=E/eT6wGWAAIHZs0eVGSMvGJjLcHJNDuN09ztN8sPxlvV13Y8hKjxWUkrcUirb9ZkVshb49MQZkVCvJi1NhvH7bTXQEgxXiDkoVYxg41pdIXQ3NZ10G8VPhRr8JeVEfebYDm+Xt19k0DRPIU1NrzRavHwNn20CkMilFPlI/9i9fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317069; c=relaxed/simple;
	bh=npgqeyJYtjMo1K7oEjKm+5dN1DpSLghDGmFXM3/+hLY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MoWIzcGmguYK+rYGb8ZssNwwnDjsJlw2s1o45P9zNSr2Eodw+5Fja/pldq55H/NEOKeLFNWRshYx51CZlDC2TbrS0xfXko0kCLWnJ0e3O5+ZmqaXgqVX9H9rqasTx4CWIoM2iKBDDN9UvDsJIUupGhtqhHfckffUYrWyAoeBWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tqe1ZA6c; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6285612382aso46505a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757317066; x=1757921866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1ihnPj/Q847d8ksRu6ToPjh3J6EYfnXIG0faI+BDt0=;
        b=Tqe1ZA6cVjwTto38GIJSCEC9QGXihI2SzcsCNgLbf/xTgxEXKyWW2MrhIjON3rmCoG
         OPFLLn9OdCsRHvscVXwX6oxJdC0SfrIfl1svSRUrqUaVcZxRQvF4L/iOQ1Ouf3fIEP18
         eXc+bXIOjogqqGePD3sM1xu8J6bDqYR7dtOhyzhqxDl9FUdXGqDbhXICahPDxZ+M0hzq
         OxdF+4pEhiusblsyfOjlHuf2Vfpdoxz1pICU7kNvV5Q/RXqjq2xTt5AyLx288hMvCKuk
         P8MzfhkKIF/uxXdaatQmSds4ZkVACHBe3bRCV5SLy8gwytyilBqTAqQjOzxYyltb02bB
         yKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757317066; x=1757921866;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1ihnPj/Q847d8ksRu6ToPjh3J6EYfnXIG0faI+BDt0=;
        b=Im3ucsC5wCHbz6uRDl43GaZ/MLeybw3PZYte3fFcylmmX7s8ASCdEGV/Sw/8mSsKXc
         T2VzUKJZeZiFagrDGDQeT+4X1dbK4vGqj0BbTTB7YxmexNAjE3c9eDiBtuMyjSB2syQa
         Oz3CYWmKyZU8CYJ0krwU6deXr7MAsKSx5hSgkcvnBnfbeNo+JzNQ1HUHCy6tSzgBibgv
         f9Qhpch973aoSqYiFD+TDADA53R98/cnyfzjoc3E2AIFgfKz1oLNyvdVNZPB04TXe9Ek
         +4dyFvEnBsXVTJ/rIUKz6UnvnfTe4Wbfs0kPqTgMbH/qJf/gQNIFast4g2HonnVfHT+n
         UsMg==
X-Forwarded-Encrypted: i=1; AJvYcCX20fYCvHrM/Qul8FC0zJpcS/ol1xxfsJ971akeQGK9i3MYnwFOcKlZBWGbDV3xLbO6q+Ox7TkDLegdicQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkX4sHlcS2bl9QNh1I3q6CE5l3vhhLAwFqwIUkl8P1Q/ywZJpb
	A/lGOrrKaKuH7qMVcVCBsYSyebc+FgG+HAfWkoXd0SyyLlDZewrJRaJuDy2FAsHpyGY=
X-Gm-Gg: ASbGncuf+8/ZCqeuB9l3KfaEzWYB9L2Ne00aKcboX6SL7hpxSPFP3UkVTgr9QwgpDd4
	QeED5stnD20bVQA1ngA2T8JTRhUCBORDcCb1DD8rE+oEYKqmqkk6c3e02tW5MX1k+5Ioo6JUYvT
	Etq3MO10YNK6xQg6I8gyHawZjVuvAddT5hQ132CzX+sJjax0sUHMlKcS3Bf3jmv5mATqbYodWSF
	DHgDusHsn03vRjwe2tu2VFeL/E6bw0/XLpSyWOHHtfLcyaKFO+h+eJ1zL8d4HkbDrDNYES5Zf3y
	PR53zRB1GRuQRBrFYB7eKWe13cePOZlAKBB0n0oq+QvXH0k9FOghrFouxc06voohePLHepa8Cjb
	zIVGh4EOjLQA2sqRH3W3nSOgenu1i3y0YqQKtYbhLqD32iBLL01k9OGEhwxd1
X-Google-Smtp-Source: AGHT+IEwOfCfMLqhq1au4x2wehLLoFF6Zs3TLFmLiTfUckQkop+xb6mWxOrGK/1CnN+pfhpIuxlJSg==
X-Received: by 2002:a05:6402:3547:b0:615:aec5:b595 with SMTP id 4fb4d7f45d1cf-6237adca141mr3186598a12.1.1757317066001;
        Mon, 08 Sep 2025 00:37:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7edcsm21955357a12.6.2025.09.08.00.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:37:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Henrik Grimler <henrik@grimler.se>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908-smdk5250-sromc-v2-0-e91b2375d4e1@grimler.se>
References: <20250908-smdk5250-sromc-v2-0-e91b2375d4e1@grimler.se>
Subject: Re: [PATCH v2 0/3] exynos5250-smdk5250: describe SROM controller
 and ethernet port
Message-Id: <175731706457.18620.18138563656034990579.b4-ty@linaro.org>
Date: Mon, 08 Sep 2025 09:37:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 08 Sep 2025 09:26:54 +0200, Henrik Grimler wrote:
> Based on smdk5250 description in Samsung's vendor kernel [1] and the
> u-boot dts [2], the smdk5250 board seems to have a ethernet port
> connected to bank 1 of the SROM controller.
> 
> Unfortunately I do not have access to the board, so this is not tested
> on an actual device, and based solely on the linked sources.
> 
> [...]

Applied, thanks!

[1/3] ARM: dts: samsung: exynos5410: use multiple tuples for sromc ranges
      https://git.kernel.org/krzk/linux/c/31f5a855f706f8b14055b6b4df083c3997e42907
[2/3] ARM: dts: samsung: exynos5250: describe sromc bank memory map
      https://git.kernel.org/krzk/linux/c/6016813c888ec7d4a1f592eab3aebf289a42e865
[3/3] ARM: dts: samsung: smdk5250: add sromc node
      https://git.kernel.org/krzk/linux/c/d19b1773362adfe8c0d5ccc4faf6aea0249976a6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


