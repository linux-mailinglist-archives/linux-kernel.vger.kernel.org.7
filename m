Return-Path: <linux-kernel+bounces-893421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A396EC47585
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72314188FC27
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E383E3148BE;
	Mon, 10 Nov 2025 14:50:55 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A869A1E885A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786255; cv=none; b=u0WYgxUn+hW0s4z9Y610wRMsqMcbxdqYldfTJkaiwdIFt+DGVSh5d7ZCJcjSYSOWu3pAIPBJN3WJYDwCQmWy+tl3DzBdsYftg8ndL/VdFCV2GzQmtAzHj1JmUczw2WFpnGPtpuGEoYFJglAwwE7WKoYMTKweqTaR6/zu8EctLdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786255; c=relaxed/simple;
	bh=IMhWei8UUtQyD2IeaxfNo1cout9WByPftYAKndZJ3d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELgF7PUxKQIYmixOVRjFpfqZ6HH0wP3M+5v4mdiNFsiKtvcpHtn40ZvKCsK506r5hyk6aph9VJGJMEGY5EkPCKo2xpyzXdxa0i6RAwV04MMqMWOEKCsZXvuXFjJczlJU5o3Um6hiTxxzFlEmjJR1NXlo7ujEf5Sr81j37DS0OBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5598b58d816so2061224e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786252; x=1763391052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6W+AZvJNrL0mTuGS4dpQpITz95eoR4mgvv8GabBfNw=;
        b=YPOl2qTmAnmg1yaBYximwvU5uRHisdkCr1FatCKVe68C7cLlE4aSpDi+IFXFgyGIow
         orJaNutkimFlB2qvbIsNUoxtraSb1ZdgmmsAKM4s7x6wpwdWyrgux3+1Se2l64x7sSb/
         sH35fobTvIngjfHKeix+JPzpFP9Ex8WT4Clq0kCQxGEPas22GxkjDBL3h2RDkWWw1t3x
         +Z1fRfX6L7KjkAvk32En4gTCsTFtSLQ7umifRZWNUq+P0Fl0Vi2ArobwagsxW9N3tk8G
         /YYkqgvym8d8xeYokEQybETaxoEgwhTo68F55j7DLsdx/zCCuzj2gtGyBZT0Qsc0YiAH
         2pEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi28Dbof7oaEbqtDeENXKv/i4474as7WSIuKy9hJgIJMyeo2tUpfo1o7PArVLXCA4GYdmy8NB4gFM7zwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRIlK5D+oVG25snCr+EEBquxssb79SI3CJu+Tq+X8Jvt+7t+l3
	K5FxLQhnuCiJxTTZnWsQuRfdFQ+H610TvbTOyohRMuJ4CJHAmJH8+u+aGfhQHkeB
X-Gm-Gg: ASbGncvVxhsBrIjQ6kHFcK4/r894249RbFEm9ZYdbgjQ0snezk+FdzAtGfL3M5/4O9i
	RBX7iAk294MUEudnBkfm1c30+9kTONRssnnFK7KLh6Hd0VjO+F0Gyj40p/sdX17yY6s1w5VpGYS
	JC42rpjq7SvQVo0RxfVBN9ozgn5//NO6QC0YFFf+/INAt9ie3bbQGsVwoqNoJpc3lwMIOI2F4Xt
	1haLh8CJqLBwbmLGKIZxzHWfWp0Vq4NfjepQqJjQnzEuInhlahd9Bozc2U36PZBc+ob61zPHk6Q
	4CGp9GITbrmeEwntTkEMqmg29zuCF4opi6z4jbQVNmsqo8QfIQSzx2vIaIBMqGI393cy5rVeMLl
	JcZO29uwzm3qUbzEsebjDSYT9W8bIPrEdvL9Qiibpm+LAmyN7mv0oSf8773k9Iw347lpTVjsllN
	hPBCI1TAqZPUz8NkU/d2bqL8VqpPZ1DDmF/CPqF/55pRNxWtOm
X-Google-Smtp-Source: AGHT+IFy4PU5mLz2YxVkptqcEgVqaztpAoZRjhyHVxm5KBxg54adSi/HojSOATEyF4DxzKUQihva0Q==
X-Received: by 2002:a05:6122:8c0c:b0:559:6b7f:b110 with SMTP id 71dfb90a1353d-559b3207318mr3095298e0c.2.1762786252519;
        Mon, 10 Nov 2025 06:50:52 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5599582860asm7612374e0c.16.2025.11.10.06.50.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:50:51 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5dbcd54d2d8so2689105137.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:50:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7ehsat92BxhB5NJP+j04R0pT280fbVsztZz0zeteUZvLP8ZI09ZLYIGjFcNsVBj0YCdU8Rmaw6iGrxRE=@vger.kernel.org
X-Received: by 2002:a05:6102:ccb:b0:5d5:f79b:e93b with SMTP id
 ada2fe7eead31-5ddc4781079mr3199460137.32.1762786251015; Mon, 10 Nov 2025
 06:50:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028175458.1037397-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251028175458.1037397-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251028175458.1037397-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 15:50:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVyMZe_6tCBaWJrHm5oEnFmYQtYjeEw8-4T3KqZOSwdBA@mail.gmail.com>
X-Gm-Features: AWmQ_bkDbMYfwCmJo4-5lhRxl2GtT1PU_uiGdBZlvXcWTikgK8Rjt2psKny3OQw
Message-ID: <CAMuHMdVyMZe_6tCBaWJrHm5oEnFmYQtYjeEw8-4T3KqZOSwdBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm64: dts: renesas: r9a09g077: Add ETHSS node
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 18:55, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add an Ethernet Switch Subsystem (ETHSS) device node to the RZ/T2H
> (R9A09G077) SoC. The ETHSS IP block is responsible for handling MII
> pass-through or conversion to RMII/RGMII.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

