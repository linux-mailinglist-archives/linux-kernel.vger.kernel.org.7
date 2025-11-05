Return-Path: <linux-kernel+bounces-885626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F293FC337EB
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1525F34932B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEA92253EE;
	Wed,  5 Nov 2025 00:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ7hMFdR"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD91A238F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303324; cv=none; b=HAd24L9vFQtZZ94w8/lCZ4NRYLKnEMOKZNTsT7LpkwehMP3fb3/HbciAiIFxbpvWvmzrDKF7eH5m+QYTKoDNiOq3Xi+dcd8WkUh+OnvBqefCfnwYS6iuR5pgCwrv+WlrVk81y/dSHHFuXsyphPlUnZVNECeOHYLdaezm9rpAc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303324; c=relaxed/simple;
	bh=gYVZhOYMPRfGjFaaFVkRzh6eCeopTRT/VpSmpXPD5EA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iA3mBbpzpXjDDvUVL+oNm++RiQLo2VxUzDyi+dfLZmpaxGM10YKLfe8PrpIauJTOHaeuLDFBTEq7dcg2InKpu1hfVlOhjonXmKmX+OkshQYIMhD3QeB8cfwDwlTT8jslhiuOg44Uy0mnPSiEb1O5+uuMJh0KubsHxBqHFKtesKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ7hMFdR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso2856240b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762303322; x=1762908122; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gYVZhOYMPRfGjFaaFVkRzh6eCeopTRT/VpSmpXPD5EA=;
        b=QZ7hMFdRf+Q/1/9qybHlMyZ5VjIHB0em7ndf4TfQDqIWJwVDlKOu42R9XwYE+rFdVj
         h/MXNf7ffJrwKQqnaqTYT5tdMm6wTURIu4zTC8V2wJixay/9SyfkiCaCQ+qRAMf8K8bG
         K7kQmMbcOmOJ1xsLCP4hpGl9muO/CJNj4NMwKXndtZ2AvESDHUOBnjx5yi4wiAUKRVSM
         SO/D30S1nsZkmRzQskZ1C2uHh8lDa5kpmoggHqiTogjKkrqjOKM67AQ3QTi7hxqF6X3X
         /LK9FasJ+QxZjczX2Zcsc4ZTw762yZZ3JT6EHTMnqanG5EfO211NK6glANZUR0a4E28S
         30cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762303322; x=1762908122;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYVZhOYMPRfGjFaaFVkRzh6eCeopTRT/VpSmpXPD5EA=;
        b=YgRKYaKM+HSjwiSbQyXxcRAQy7cHgyxSU7vzGHzXftsO4VyTqpmAhwU6s41pJ0O+VG
         F7/ZXGmjLPvL226Ray6dTqJC9+cgR8p859c6F8iAZvp/LiSiWqk2UhnqrAr8cY1C9cKk
         TFU4bY6+IVzXjSi1HsMemMvIZVnBj0B2KhPymXb0tGvXDZE0DZbtbrgROdcP48Kmi7jy
         WEwGw03mAGJhY+Cv1sBjcZ53Le8gH2LeeKTrzKr1/y1YEHfjfDUqMvZRE1dFYm1FuwcZ
         +y7bM0tmO2QQCx3oDNmLVUFJ7BMTxx6g5157r6UA68X9jFJXTSGYPftOHwMaqL2bYX7r
         rVww==
X-Gm-Message-State: AOJu0YzmkBrRkbTu9azCq/f8ay/rC36TdcfsMTLhKjwsXmuvfiouSYdW
	Q7Bb5y59e84JvLuCUiDOMJ3O/lbSWKMnK0lxv5lurtU2gVvoENkWNc5/
X-Gm-Gg: ASbGncsXT62KDPfPz4hZTKL5JpEV712NrHDd3dI1vaEaqWXdngKAG2tUDwklZ0Z6n7f
	yBwaIV4/TBLT01Sj7uveoXLhRFH2bDxX5tli9gW5lU4iJc+YFU8rVIwzuU7KDqWZe5E6P+HnhLk
	3gFrwE1b31yM9KJsO2Oa8JhHdKwpA8x/XseEqQiMObphXyIg/09cIveVlXmCcRhKP5B6h4SF5tF
	KDdaFIdvRCChpO9OARR5EDqA5iqSDyQyPxWTuAgYqXDsZiPRmyk1CWyHk7xsin2/mEYlJjoSKfc
	1K1M8mHqjbWlEkDPHtppTspFIMZPVtocVlTOL/5i1IIYRCNV1PC8Oz6AFuL1K+rw7I77mkvh50Z
	UiZyAAC5hcBdoPMhVWM1JMURyVIitpX7AuRu5VpMHsClb6/yNzuWtDobGNpefuqn5cdDFzD2VT+
	/H7b0m8aXSfoEV/eze8LYzWaA=
X-Google-Smtp-Source: AGHT+IGlCkp2SIrycBjc/coGvTISsaGEuTwt9MlilZThVHmTxGZjjFRoJ/A4sutmB2eGMGsbS6qnYA==
X-Received: by 2002:aa7:8891:0:b0:781:be:277e with SMTP id d2e1a72fcca58-7ae1cb61439mr1442287b3a.4.1762303322289;
        Tue, 04 Nov 2025 16:42:02 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd586cfb4sm4367000b3a.46.2025.11.04.16.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:42:02 -0800 (PST)
Message-ID: <81753c119e02d3a8158328ec5d3cc6fd128e68b0.camel@gmail.com>
Subject: Re: [RFC PATCH v4 7/7] selftests/bpf: Add test cases for
 btf__permute functionality
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 16:41:59 -0800
In-Reply-To: <20251104134033.344807-8-dolinux.peng@gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-8-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 21:40 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> This patch introduces test cases for the btf__permute function to ensure
> it works correctly with both base BTF and split BTF scenarios.
>=20
> The test suite includes:
> - test_permute_base: Validates permutation on standalone BTF
> - test_permute_split: Tests permutation on split BTF with base dependenci=
es
>=20
> Each test verifies that type IDs are correctly rearranged and type
> references are properly updated after permutation operations.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

