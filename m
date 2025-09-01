Return-Path: <linux-kernel+bounces-793892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDB7B3D9C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363831899A78
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCEA252917;
	Mon,  1 Sep 2025 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0xuSYst"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903426281;
	Mon,  1 Sep 2025 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707670; cv=none; b=WAt+dv3B3lyKHyAbDPjVUW+3pcCbNOowECYni8dwIz/twrS7h79HdBBtbfGmts5bQMCkUvELH4bPAhQWzy4go1/UY4Di6h9+dMqgZIw20BFB2ofs4MvhzabTcRDGjecYgWN4/1XKAEJj3xGMU8wrZZYa7zmARzxljjqgUaYnL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707670; c=relaxed/simple;
	bh=jEIt+3X+NGZuxr9lCHefPQ1whPLGQgrV83ljVA6Wt6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWpKQ/67dTtCmkjui4uTCWAT37JE9QjLm3N1o9Xrj6oV/nGzlT06awyKkOjaeAUgT+XZv9U9BwhunNb2ia53AwO5q1RXijj/GghQWjQCFDaXiyMBAWAtBbu0ZmlYFiv45BA8GJ4hDOsT7E/yZPISu2XZLBVaWdq2j8T5MrDgv88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0xuSYst; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-248cb0b37dfso36514105ad.3;
        Sun, 31 Aug 2025 23:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756707669; x=1757312469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM0VzPvZOoadSqld8QAB06APoe2QVLiP88e6xJF3DNg=;
        b=T0xuSYstdI80rU0YnJ9hOfd95hSAenLjDIdVF2GbYAQAcfhoJwGfEymk6n5mSrRVej
         lNZhRVtXLvrVLMZ3fDqaXWraqq5v6UFHp0IARqUwE4m7kNxOPVVE6GSMoWGFNlfTO2gA
         mc/GN09EUgnGh4Tq/qmiwkJOyoPoIRhd0qiFjR/R6RHAdmkdzJKeTGB4ZmPAQG1BgH+2
         zNJsCoj6KvJ/dfVzZTqEORbmiVHqlJ/a9UW0tvGCwBndYc1IWgYzcSRpew0UD86C1BfC
         Wah/JGH59Vd4FB++7WEsJMLjCrzuFkRDE/9QhNHpawdhv//Sml+LrlTCLElWBN/ctWq1
         K0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707669; x=1757312469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QM0VzPvZOoadSqld8QAB06APoe2QVLiP88e6xJF3DNg=;
        b=omDEuZOJYOtz9d4iZu0/uokRWU514a+9N33KipodqPrLiAfmH0gSj9VOxnxDH6aVYf
         1JicnvtjK/yfNAm3vhNZvGPT/tQUlV2pxLJgajU9zxGFXxEVs2kGia7rn63U9pTmTtZ2
         uDeH90EqKEZHrwz2/YvQwQIEQ5DHDjVO/4hogx19AncYkkk27+CVexgg82hp9ji0lp6e
         rEZfz/hW9AdWX50mhJ9VcoB6btQGe9u+lfuXNfswo+EJWQwvrORSJImoODjx1JonexaE
         mrzsyMrr0cW8KGjAnOcMfLLakq/T18Igv7GBo9IFZIqkEJLWdxNHFXZ6R+TRy39pKomz
         ycGA==
X-Forwarded-Encrypted: i=1; AJvYcCVBkTLcePa9Jc0IteyN0E/DcqevCzdhtPpCgh7EbesPcxEnfRYjQUkyMX622bThaCcUGLrzNyk2RZYGg77b@vger.kernel.org, AJvYcCXJXa6xGXFZ19WwtKn04cTp11swMjq5L5xq8x5ElyTmzMMp9DXsWT0pM91w6mIH+gaSdqhmmRkhUj+/@vger.kernel.org
X-Gm-Message-State: AOJu0YxPW4IEzuvq91o1VSOusx4ip98I4rmVJMkAjq0a5gv3iYKTf7cj
	3qqIaHZBofs5WERuqUnwrVosfYWDDhOrndjkDvxBhzg0LRUe7Lgmiifs
X-Gm-Gg: ASbGnctAfOr2eDd/Zce1wKfjWw5UBUTmZ4bGlukItbGwv+JgYl/msdQt7tgy1llfq9q
	Ycl0BOAzfEq3J5OnZzF/uvcV6c+r1BlUwlY0C2yOZygurxp8efZAnVAx99zI0fj0qgDjpk+OOsX
	Fy3LavErtYem5OTiPw33avDCea7/wtlrc6+I3rdmcvX5my3bP62EghUhDe9hgAvYYITk22m/FSh
	N3HGAsT+uGKFal30KqEKP5mJhybIpwBl7D4W2pr84oL9acRco6IThdBp6ckqHJfYbfGd4pnKRQT
	sCjhZUTcGcj9Ytmu6iwpX8aX0rVO4KTAaWQ4NNSUgO/Sx5V812FGQgwfs/oKBQlsPjOVtDEd4Aj
	YrETxls5J3S+GKfOr9fLOMHpSiMaCuvXs
X-Google-Smtp-Source: AGHT+IE9RouoLA3mI1WTQ5bC8+3a6e/YddQasaUm/tDoSV5izF+qFjCdAOy/vlAmLw+ht6FR6TIR+g==
X-Received: by 2002:a17:903:2347:b0:24a:8d5e:932 with SMTP id d9443c01a7336-24a8d5e0c28mr78375115ad.23.1756707668708;
        Sun, 31 Aug 2025 23:21:08 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24903727488sm93506135ad.43.2025.08.31.23.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:21:08 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH 0/4] Add SPI NOR DTS node for SG2042 SoC and boards using it
Date: Mon,  1 Sep 2025 14:20:57 +0800
Message-ID: <175670760972.211032.6732897578408758943.b4-ty@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com>
References: <20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 16:33:16 +0800, Zixian Zeng wrote:
> [PATCH 1/4] and [PATCH 2/4] are copied from patch set [1]
> [PATCH v4 4/4] without content changes.
> 
> Link: https://lore.kernel.org/linux-riscv/20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com/ [1]
> 
> 

Applied to dt/riscv, thanks!

[1/4] riscv: dts: sophgo: Add SPI NOR node for SG2042
      https://github.com/sophgo/linux/commit/268b9620d86ef002b5e94355e80c44bbbdc736f0
[2/4] riscv: dts: sophgo: Enable SPI NOR node for PioneerBox
      https://github.com/sophgo/linux/commit/6baf562e0474b2885405cc8e383a59269807338d
[3/4] riscv: dts: sophgo: Enable SPI NOR node for SG2042_EVB_V1
      https://github.com/sophgo/linux/commit/2ea345ad682e2ab89c4360bdf90fd170612b3be9
[4/4] riscv: dts: sophgo: Enable SPI NOR node for SG2042_EVB_V2
      https://github.com/sophgo/linux/commit/0bf26eecdd2a6d243a3a19d3ea0df10437ed33c7

Thanks,
Inochi


