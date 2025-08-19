Return-Path: <linux-kernel+bounces-776511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B4DB2CE52
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337D35A2E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA3B343216;
	Tue, 19 Aug 2025 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSBJiGbt"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F22853F1;
	Tue, 19 Aug 2025 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636804; cv=none; b=NXIFpRnXKX1WtmLCfX55Sw5ZRhP9QGw2gWKxnWVXW1SxoyQXX0cZafY5Av9/MbefCAlXt6YqsA4wUUfJK6CmV0vdMy2TMNcA2i1GzWiJXlqubmoOUPi+zHpHf3jg03KrOD5ERO9wGbjt+jVfEa3PtfQcDnG4G0YKiKRFX0Uom0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636804; c=relaxed/simple;
	bh=VpY1fE+yc5JDErEIErkymNTIteIxfr4IdhobTC8yv/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKYmo/tHxt6Oy6XzfguQ5Lf2KK1f7NO0EGqCBAYNejWRZD/QLdhkbEOHvGRqV4HlyX+EUVcCXq1fenHGpnp1+2cuW2fkByT+/kY4PlKMrjuWe2RaQrkF0H51y3UUd334luu16870M4jRXbhJn4aBcFiUZaEN2S2kys63Zkila5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSBJiGbt; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-435de801abeso2123709b6e.3;
        Tue, 19 Aug 2025 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755636801; x=1756241601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cccifdKxwgVIxGkwbmtQ1TWALCMGZnlgxiuGwopgW2o=;
        b=aSBJiGbtxApBbJsL3EsLS20B5dPaqnJACepJeQMPESX3v5qargN1g5LD/rFNrk7RIM
         RbuCTQlESmQmZcoSbNAlCLAu3UCHukRN++jsvO1FlKa7SLC7AzLJgVbsMyH94hcZZD8h
         qIKdSV6EIZ8/txljzN9tNdbjVmiGarkVi71ZXkHen34xREovC5x2rIcWmzoj/93jou35
         Cm6dwYxXX13WHY4p2rdTOPg6BH6zEMFvCA/NxbOje0glsPNF9/RyKxTkiTmLTjM/uZP/
         /yzc+yaG7h/KtnPmsLioyXXdtKkseVQvyU87CmzAgngxYMpR5mo9nBy57FKriyiK4AX4
         ogyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755636801; x=1756241601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cccifdKxwgVIxGkwbmtQ1TWALCMGZnlgxiuGwopgW2o=;
        b=qgsHHkS30PpYHfuk/I8GsjPsCMQuG3CkxIWG409QmVt1SrE+M2p6o3b1y+HDH4n1Gl
         ek6oVSpB7uTkvvK8vViSdUItCiwm7z7EFjPqMH5eXJkG+SvJ4DN0nRl38d8bVizQSrUp
         3vsIRmOhpPnT50vNevIMRngl/DWX6DVkrr+VXiaZB5WeIFLtCKItQAv47P4V1iHV3Jl0
         YWQbY97F6DkLt3w8KZpfZT6GXZaQocmUtcp1/4bMKCMm9DEUe1k5wNy3pNbI9NQI8Kjb
         aWGzY3vThmxGQWZ1tsIop5gv9fi7cLg8A+WbSjO4wylflaluJaJ0HPU+tbWOqDK9zVCN
         dalw==
X-Forwarded-Encrypted: i=1; AJvYcCVQtelsvDkPJxkNq2K8GZ7sCZ5qyVUKWshK6qG86LGaQvXG3JPI6BaoJWHYzdSX1CrdzUyZAAF+6Lymtv4=@vger.kernel.org, AJvYcCXNYhaxQZ/xma1H6cDRVSZc+2DswTEc5EuCxPICnkOfy4Nyrg7cZcvtMjHlRzJN7n3+aWgU38suKiebpOdHuLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwngU/bdv26jos2KTjeLdJDkh5efszZqjSvGriGhuS5Ac3L0YxH
	1T9SGbskhsOCg4eAHoG9TJTi/XAww0UrsTxmnH63nRJJslNFPfQRP6QT
X-Gm-Gg: ASbGncvgHliQne+zdJmXpueJIE2mc5zUjaycyjg6H4xaT7je6mxNFF20eGYrlaQ8Z5b
	EcfF2rZN64Ppw3pBnszAM1zjHr4qBWI5NmUInb6vU4cVaLTpz6MUf91jTOHRJlAKD6qcRdWP38w
	oISLCeGDjVUQ+JpCBZzGvFEJKi2X2ZJk9Q3nXIqunmzrl2TQI+JX4aqw0fO7nfQ8p18tAKBqL+t
	cMMxmJLbiC8022cVm1HzleWD3O3/Wg8JzYrZrgclR9WtUifuQqkLBxSD0gIeelPspREBUiQ1GIs
	9ImGC66ds/Ns96i6WnuPh2lY0h5JtgDHBy/2/RM97ol+DCtQe/nbgsrRoJ+fi5Z+M5TyfUcI2TX
	jqTG5dWuOcDVWAgYbjHsO3U5zgUDTg63SVsuSeHDjB1tKFmaHKdAh+N+lc6gr/Dm4IM2RTQ==
X-Google-Smtp-Source: AGHT+IFQLVe/eYDYQgpfKh6ZkPeTyExiDauVdsWHpI+hmDZYMy7Hx6bM1cNBtQ69VAPnx0ro0riEjw==
X-Received: by 2002:a05:6808:190a:b0:40c:7996:73e3 with SMTP id 5614622812f47-437720d8318mr245421b6e.28.1755636800587;
        Tue, 19 Aug 2025 13:53:20 -0700 (PDT)
Received: from [192.168.86.39] (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed0fd6b5sm2480745b6e.5.2025.08.19.13.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 13:53:20 -0700 (PDT)
Message-ID: <0d4bd6c7-4611-4b7a-bc07-8b18336e74ab@gmail.com>
Date: Tue, 19 Aug 2025 15:53:15 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] rust: maple_tree: add MAINTAINERS entry
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-5-229b48657bab@google.com>
Content-Language: en-US
From: Andrew Ballance <andrewjballance@gmail.com>
In-Reply-To: <20250819-maple-tree-v2-5-229b48657bab@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/25 5:34 AM, Alice Ryhl wrote:
> Similar to and just below the existing MAPLE TREE entry.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Liam: I'm not sure what you prefer for the MAINTAINERS entry, so let me
> know if you want anything changed. There are also a few other options,
> for example, I could just add the files under the existing MAPLE TREE
> entry? The get_maintainers script should still send any relevant patches
> my way because they also match the RUST entry that has a wildcard on the
> rust/ directory.
> 
> Which tree does maple tree patches usually land through?
> 
> Andrew Ballance: You mentioned being interested in being listed here as
> well?

Yes, please add me as a maintainer.

In regards to the discussion about the maintainers entry,
personally I would prefer that the entries for the rust and
c were separate, just like the version in this patch.

> ---
>   MAINTAINERS | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 26053163fe5aed2fc4b4e39d47062c93b873ac13..4a52d884e36eafe1c819227207123c51caf02ee5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14674,6 +14674,16 @@ F:	lib/test_maple_tree.c
>   F:	tools/testing/radix-tree/maple.c
>   F:	tools/testing/shared/linux/maple_tree.h
>   
> +MAPLE TREE [RUST]
> +M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +M:	Alice Ryhl <aliceryhl@google.com>
> +L:	maple-tree@lists.infradead.org
> +L:	linux-mm@kvack.org
> +L:	rust-for-linux@vger.kernel.org
> +S:	Supported
> +F:	rust/helpers/maple_tree.c
> +F:	rust/kernel/maple_tree.rs
> +
>   MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
>   M:	Rahul Bedarkar <rahulbedarkar89@gmail.com>
>   L:	linux-mips@vger.kernel.org
> 

Best Regards,
Andrew Ballance


