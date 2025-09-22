Return-Path: <linux-kernel+bounces-827921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83178B936E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9318B1907A06
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAA430ACED;
	Mon, 22 Sep 2025 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="DiP2mvyJ"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A7B2F657C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578911; cv=none; b=QcgUvfp+0wBAnr3Rb0aU0PJ6k/Chl/Nf17OIslJyc/ZnRMcsRGKfQn1ooKNhame94RceUIoiZPlHLXwtl57jvm3IFA1fPUG2gVuVT+ZSRm1cMMJGHw8tDLVn8jiOpyiGtHGl7ftGW5FKIJi5PUB3YpOaqhbfSJbUaoDcsNxSJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578911; c=relaxed/simple;
	bh=Avq2y8MdAwK0oH1I3MtgdoQ7iSmzzMmfx5BVuSNgHcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQ/B1WpwXToZNNP4RA9IKPA6flpSLGelsJ1ijduPfdBiKWC7UrO/kOxiX09vr2UDtG/op2AK6XV4xxPthkP/2c2sJe1OyXBY3NeeHji2k8QyyzuW5yB3kgqTVUspI79GEC8PZMgHkODI+3oOR4UH4YBsy3YpC1owffn7HcFDn6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=DiP2mvyJ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4cf068ffe4dso9047061cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758578907; x=1759183707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUjK8kSlRwyRA71ulpxBj11meZbRhX9iUJHgvPDIzMg=;
        b=DiP2mvyJuIZZFK+eJLPbZUHCc6UaBSc9TK3FZS151JBFLCG/GX9fPPQxPy0Sp4k1Fn
         53or6umbFGNkReYKf4u5ZcpusSmNM3dS3SqV22/YMulrgkPl59n0gbOZNKUdXgs5zczh
         KalQ9xJdgzNZbv7jbaHUSrjiuy47Oei0gsJjj23pSwIFD/2v1Ea1xU/SRxr+bH80UtEn
         h+dELNBmfhpx4lHWlWHZ+ChXXQdNQkgQV5+7vE0I3NA7HbLAk5yzx1cJYFtZvzr8AuCQ
         7fnBqcmkzX/GwV61QVDcge6Yruf3aynVZU+U7Bo/bx+EXeT9+N6WS8fEf14JKt0QZZbl
         aswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758578907; x=1759183707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUjK8kSlRwyRA71ulpxBj11meZbRhX9iUJHgvPDIzMg=;
        b=CLuTLQPdgpezIQ8047IR4/0oGh/2cSlG4ObKBDuoGpPPI/xAdF6+cDvoh8Tb3OELsc
         9gZq3HChrxguLyXPevv4pi+d7dbdreVwnOAISDUrOKMQQG3Y+VtbZqrIxyZHMMC8grCd
         mOpGdzOJz9JrQVKujcJXOTxRLzHXGXJ19UQn1ZFm0LCimfkXc/ZLAFYOBAcsOrfnN656
         6N9nFD/YsLz+IDv1pD2tmuOXwAK+aEbWFQhYehN0pQL7WQz64zU7cJ/8JqsiC7GN7EmH
         fLtBIruaXYmDnpiqkwP6aomNOeJ/hebnVQ5su9rydtZ3P8ALNgKQc5EGqrKQzaPmDBSi
         ZRNg==
X-Forwarded-Encrypted: i=1; AJvYcCUobK1ObJ6J6713ZGiN6evT0XFu7hFIH5Jtx/HdAb0j/65HDg7JfUL46W2SaHYK/0fuGidkHIuJCd4EuuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDUOI3OhSl9ULir5s4bwu2P9cbdfa8aVJ/FbDUlaIdEOhn9ylN
	9qxjRKsDG2iYaS9pqUNgEv3W35y6vBBffMb7x6QN0aBOqHLt8QbWmoI8Lwfmv+HWI6k=
X-Gm-Gg: ASbGnculfRZCyYl4we3djLMH4olZggPUGM4KncTe1SQegMvHacBxMKIsmL9p0lBzUBj
	PL/dnvGsRssvrtdUc6XoulFEVZcOZYG7K0CWbHeUHeWemxTfTx4PqLbIVnehQNpo8rZpj0gZi5/
	/GdTcG8Po8esMZXLFjGljIF0lq33DjnTrdcm6riVvdpEllHbQz/bQItUZyHhOwa0Lxrz4JRmfwj
	6gMMZ3VqfpBauyOPqWO8enaoRJqREjx1agvY4ZpHUBq7PFcB7uQ/luLENt9fN7dTD8uLrIPp+ku
	ppdI2wdO/BV4++fjZ5qH7OTP0CMKFkDwdEnxtPLkl4Y6++yfV+qpLo4CjyXSJZg8rSB0CJsAfv5
	RxMbdmaYcFBcVy5PSWNt84YjltGKhUbRj7bkgqQOBZyIRmFQcWlmdRIrorDhwvmCKufvBWoV0tI
	4=
X-Google-Smtp-Source: AGHT+IEz0icBL4xjkfXiOd9WdBXGddBAYbpiDBXZ680UQhfkHWQJ/JZKh5CbDmMzNtrP9ERLzyDGHA==
X-Received: by 2002:a05:622a:450:b0:4b5:d586:d74a with SMTP id d75a77b69052e-4d369db6905mr5212111cf.37.1758578907176;
        Mon, 22 Sep 2025 15:08:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4cfdd34b180sm13096701cf.34.2025.09.22.15.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 15:08:26 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:08:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp
 <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
Subject: Re: [PATCH iproute2-next 2/3] iplink_can: fix
 SPDX-License-Identifier tag format
Message-ID: <20250922150822.3fce0568@hermes.local>
In-Reply-To: <20250921-iplink_can-checkpatch-fixes-v1-2-1ddab98560cd@kernel.org>
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
	<20250921-iplink_can-checkpatch-fixes-v1-2-1ddab98560cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 16:32:31 +0900
Vincent Mailhol <mailhol@kernel.org> wrote:

> In .c files, the SPDX tag uses the C++ comment style.
> 
> Fix below checkpatch.pl warning:
> 
>   WARNING: Improper SPDX comment style for 'ip/iplink_can.c', please use '//' instead
>   #1: FILE: ip/iplink_can.c:1:
>   +/* SPDX-License-Identifier: GPL-2.0-or-later */
> 
>   WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
>   #1: FILE: ip/iplink_can.c:1:
>   +/* SPDX-License-Identifier: GPL-2.0-or-later */
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

NAK
Iproute2 excepts both formats and both are used in several
places.

