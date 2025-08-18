Return-Path: <linux-kernel+bounces-773930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7A6B2AC80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9739B17D231
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E8253F13;
	Mon, 18 Aug 2025 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t8dIHHYV"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA88A248F72
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530221; cv=none; b=J3FeseT1KERKy/uoEyM5X3HbGYObuOxV1RsMnXyq2VHXRB2+Yvbd7njk6PnCHOfNAGzGUsIC8O9Vy6+eO3kPCRH1syf+aSmrpELy7OLvvCh5uwvhnrMMxtV+xaGJYEyKmRRrzLlCd+Ayvgpy9Ve80Veylbcgqyh8hGG7/wmjuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530221; c=relaxed/simple;
	bh=ZQ5q5cwLBvzEWKcFeidAaKR4mpwl8Ihe+MXj7VrWfMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoQXDeF0rsIeZd50qPZt/C5Ql1mNGQlbPtg/YAMbYTknBlJiJj7KbRO2tsG8IJdq6/pp8m3QG8lmgmF0PtmAfZ7UbfWtB2CrOqsxRKeYluremiwlfEvN42FFqFVjkXeCbpxC+/N8pQgPkewjS1uImifGhmdahm3aflDxv753dpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t8dIHHYV; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cce5be7d0so2071321fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755530219; x=1756135019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3c3Gvew1aX6fRPuhI9Jg/FD49YDakQTVCTXjiPRQnM=;
        b=t8dIHHYVFwQr+rcY69trDG2w2EVOJ5jP9uBnl3tvtiVlgQKDq40uRUyzCVQTGzRgby
         e2smdDMUZsbt9Jaa47BMq7zarVoLTmsqfAdVrQmCOsJwMznEwxbMP3/72Hjz0QoGoCD9
         AOc6mjmeXl2svHZnrwx5QltaulCDP1uZzDlYoqicb4shEjmQh5wNknbYtlm0WjRzqSgv
         wfdwXYE8l08PH/JV7WpbJ6BILVfsUCtZBX0cuGe5OXKbZYoph2HZj95c3WeLrlED1Xst
         9r4fe9ld+5R+87Ib7/CsLQcXGg0HdhBWs2+85NTGFZ2qnyswiL2EVC1VF7MZSqThWBlC
         6Qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530219; x=1756135019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3c3Gvew1aX6fRPuhI9Jg/FD49YDakQTVCTXjiPRQnM=;
        b=RKvG9+YRX3BVUsJUHeCe0yxM4DMYhL4LDE9vQTXk6M49TEfomy6L8iJnM9GO9bFbzr
         EuiQlCGEWr5j+Q6y3cBg9Rrwu5HCQxdPgobSvXuQrPnW9fEHyWosVdho01E9oNEwJz5U
         aab4tHiSwF77E8Wi4xCCYWtHZ8/3WjUOBsZ8ldJFE5zwPBNwiYS4yJOTrz7C5VdunDXo
         31bmrfDeqCwsiWRkmWhH0fvJ2ABc2gJjLB07K+ugW7vND15M+ssggOj5kHmpijdca2xV
         QLbijdZHRnoYNcIxlMv0anQ1dIZroYl+RVNZut0kejJ6zle4R0TiuBzfcRxGWtccSFyW
         CzsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTJi3y59Tbj1eftb2miJG9lnVX4XJ0nzuU/gzHFni6xcBeRbaCrw4beK5x1LdWPfECceDcpCZy0C/W01o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzi0lTXdNz5zNVbX7HdUfdHrB6Z0I9ptvBSp80lVHrus14Ac3L
	/gw5jHkGM+yibudnNn1/amf/43Bfmp8dYajZVAQHS39sKT1T6NX+jJhWhMNLaM+MNeM=
X-Gm-Gg: ASbGncv5HtLaI1TJLZlvITPcuMblrOcPRvwoffmkeqaUiD+9JfCNYftwMirzlxW+oXl
	tntMBH1jdeICw4pAYX3s4Aa+v121rmoB7/WBWTBQSSWjSCmlFufaMbaqn9Y/Ky6huARcSb/zFc1
	qhVfwcGD5fVZtUBSoXoGPhM3ko9KBbarz9VWZDsTFTgcOdDgzcw7gIvxte4lTMnOkuTpvFCrOrS
	PIbmNNNcmkHLAy2WxT+sQlAvTnx0Q1amRuqgeDnmqUBhS7XUhsUsUFIMytjziiEN9zW2F1eoB5v
	vofFrVqtKDJR0G9ieLPdS/Rlb/RMRqPW7uaiZkXxNIilTXJl9SakOM8x2iURmDaNezaGDJ0jlzo
	UVTV/w4wY8GLpvVhkiDuyAGqlfsyeoD30cOqKmyejWhUE6cW1MO/j1nHI/tR1c0A0qImp2LcZWR
	EAokrq0zC+7g==
X-Google-Smtp-Source: AGHT+IHZyxk+kZ7n3rFj6tDtFYVDJ76v+ifqvF7+ofV/wgR1Z5viCvG2a2JUh6/y2oi4HtsHAUqRNA==
X-Received: by 2002:a05:6871:7283:b0:30b:c9ed:7f91 with SMTP id 586e51a60fabf-310aaf7bd7bmr7700347fac.31.1755530218704;
        Mon, 18 Aug 2025 08:16:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73? ([2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abbf853bsm2713127fac.32.2025.08.18.08.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:16:58 -0700 (PDT)
Message-ID: <a7ce7e35-b761-49c6-9e8c-e3f849fae846@baylibre.com>
Date: Mon, 18 Aug 2025 10:16:56 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: iio: ad3552r: Fix malformed code-block directive
To: Jorge Marques <jorge.marques@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250818-docs-ad3552r-code-block-fix-v1-1-4430cbc26676@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250818-docs-ad3552r-code-block-fix-v1-1-4430cbc26676@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 9:44 AM, Jorge Marques wrote:
> Missing required double dot and line break.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


