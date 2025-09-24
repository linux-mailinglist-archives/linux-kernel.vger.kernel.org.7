Return-Path: <linux-kernel+bounces-830639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC84B9A312
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 394807A8BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61065305976;
	Wed, 24 Sep 2025 14:14:13 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D723064B1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723252; cv=none; b=dBJVAV7Y/dsXIDFWfSypdCRz6dbBgzgR6EfFd8wvZolSRr/Ez97W6ihjSJgk2X6HYkB69XvutpmI55byI5w+9qBEa6xGZWOkzOGcjbJBXaGdNY3F5XyUM8m+TmMzVj9n19Z1+aXFXxNVdD9UgTS7RolA6JT1GG2c1XB8sVcQLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723252; c=relaxed/simple;
	bh=HBVkixXC6UpLk/eCQCarn8ygZtWWeyWBTNoBVx3DstY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVNxJQxVJIyp1ANPpIe1uxL93s9kf+C3PgYed2/qmyKQecxkA4kTymKBioJF+VNdfm8NKjNFphddWLlYn8YRqaggG0oKtXG/AiGg3kjkbYM0PjB9EgWBDmckYVxiKZV3xBFhVM5bdOOkXVRB7HI38SNYERpS9i0qqtXP5Gt47d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-816ac9f9507so104844385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758723250; x=1759328050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YeMFh8fKXfFfV77chei+2rVcM7wYWs2LWA9oczHhuiE=;
        b=dk+PqAfm6CzKhJAsjaR02qkIn576bCx5LoXu0s72k+8r16Se2VJ/aUI/0+oYogccjr
         H3jQStJcynkJ+CWgA3ttSNA7Ya+fzVh2Gx5EWi2XWs8ANI5VCp3z0wym81FQABzbSLPW
         b2petKFov8XuH+8Uo5xLg9u00qaVeBRISGMwaJk+d1MdGUtcUvwvppqWHYWmMdKwmqIT
         xeigEEGUPaO/ZO1tM17mJo1cYsJpsnT7DuDUp/qSj/RHuLkST8ofjrw7MsXalX4gmf99
         ysn+9RUf133Sg2ULd9pUYk8KoKlVl/hKtKaIloaEdOTYhsLT6kjHEndsFmRoP3/uYSXN
         AUIw==
X-Forwarded-Encrypted: i=1; AJvYcCV9PBELT2ybSW+wZJBp8IrrKNk/1nSxoR+Rhbs5swDCLzD+kU6LZdbTgQD24usIOELDY0rptFVi9G6Ybag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXXSVEtTFSW+EpIdSoXem0JyAchUN1dM4i4fRzKMdYPzV1wYV+
	lL2rYUx3VxUvsr0oV0n/1ouDMC3LymLYC8bpKjce83F9HyQDd1DFxiq5mH11NdAm
X-Gm-Gg: ASbGnctM44Q8AWGKLDwQQRx6yMK0XiXK1eJ8G0Fyisyg5Gpvia+FToP7g7Oq21czGs9
	wGilJ8BQokzus7OJnPcbpDyAPprfvOI+/JM9PfjL41xSCl9fhpEAfq5p0eAmIjmmEgSoBCPzNUa
	cx/9zq47jcNebytlPVdmLB4dS2k39sh2CBDa1JPX3rZo83SgtXbmhhHNldHFwgFOszP/7MMm6dq
	S+fLmJpqYKY5b1gipLExh+KcRl6PeH0YPatXcM0eGcBm0JpqntAkqC2VuXkqXUXUyfA0lXH8x0c
	UhOx5pRJrPbNwaL0OP7eXl5Zvv19koN594IO6zvkz3aHvGvpaR1mhUr6FMyMUstMoz+DsRMhwQW
	Yz0j/vGRB8OZ/Cy5smh5EXULrNoqhwxhJaQTKfZSe7ZXausiw5APS9VOruMRlLdwO67N1aM4q98
	w=
X-Google-Smtp-Source: AGHT+IED24AbQnVymrgn5S7zOQ3NqNl8q2eNlpXMsuZMBZZsxckpCoI99U70EfskzL/+MmQNwee/Rg==
X-Received: by 2002:a05:620a:1924:b0:852:b230:220e with SMTP id af79cd13be357-856e1d5c083mr285587285a.2.1758723249783;
        Wed, 24 Sep 2025 07:14:09 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836305769ecsm1184980585a.42.2025.09.24.07.14.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 07:14:09 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ca049e90b8so7813171cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:14:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUF6UYYlt9puSho0VMglS9guWgCv/i4eNCBncUyfMT97++9DX3dr+BZyAAk1Ebeo5fbirLD2JRO7E2+qVc=@vger.kernel.org
X-Received: by 2002:a05:622a:24c:b0:4b2:8ac4:f097 with SMTP id
 d75a77b69052e-4d85bec4dd5mr30176331cf.33.1758722832210; Wed, 24 Sep 2025
 07:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917170202.197929-1-john.madieu.xa@bp.renesas.com> <20250917170202.197929-4-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250917170202.197929-4-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 16:07:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUw+cVtMkfnWjuO6BUNPRd=gZHhiD=KqPxugrJVLOe+Wg@mail.gmail.com>
X-Gm-Features: AS18NWDN65f91eaOSdFfPam9YAakFHEyWw7q-5E1Mc_B35_vALhwRHePhcWpJeg
Message-ID: <CAMuHMdUw+cVtMkfnWjuO6BUNPRd=gZHhiD=KqPxugrJVLOe+Wg@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] arm64: dts: renesas: r9a09g047: Add TSU node
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: conor+dt@kernel.org, daniel.lezcano@linaro.org, krzk+dt@kernel.org, 
	lukasz.luba@arm.com, magnus.damm@gmail.com, mturquette@baylibre.com, 
	robh@kernel.org, rui.zhang@intel.com, sboyd@kernel.org, will@kernel.org, 
	biju.das.jz@bp.renesas.com, catalin.marinas@arm.com, 
	devicetree@vger.kernel.org, john.madieu@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	p.zabel@pengutronix.de, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 19:03, John Madieu
<john.madieu.xa@bp.renesas.com> wrote:
> Add TSU node along with thermal zones and keep it enabled in the SoC DTSI.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

