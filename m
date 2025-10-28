Return-Path: <linux-kernel+bounces-874129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332D0C15964
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5DE1C20736
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B50345CB3;
	Tue, 28 Oct 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="F+asoayS"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12501342C88
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666198; cv=none; b=SVXXfnp3paPyiaRkaHRI9KupZ2FhsZ6zNQyHb6z6meZV24vycUXpNYyjgtPtBaVkOwNcVnn/AL83VJKq8JfGEadiRh3HZ/hWWhRzm2aXH+vhZs2TFUi8Tucpe1v56ndAvSqvvns96TQYdxMavFNspcX2unr+97/JTKHJ2BwJeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666198; c=relaxed/simple;
	bh=p8N0VHY2XpMh/L81W8FzKQHWHJk+NmZNjv7GuBCqyQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0XF5o7vH/PW6SdVdwfHDFE3iVQ4DLTEGWZEzUhohmkrW8KS+jkQsOMreBpPpSISRJlrdVCaHshrLiOF1OGWhvZwuQ71y0edBwTkomhHIGsQY8jI6HKdD3iX1a90X+lr7zKTAMSRR356keU/JiIXbdVDF74Y1uqmuA8QgvCWjKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=F+asoayS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-591ec7af7a1so6310376e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761666194; x=1762270994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=do7MuCP88nOM3eMBQKiSZ63kBzTalMH1rd1ZJUZo3vk=;
        b=F+asoayS366GanZ5Gwtp4/aKW1G2d3JPcsnw2FFWfWbb4AWL5KcNSPx1XZ/4pah/WQ
         KimGGQzgEriuGk9jfql0Ae7FH3H8UTDm57K5EotoyyHCE3D+PIqlk8PPwuhDwVi0jl6S
         cu8oKVb3aXHkarELOAeTMXfCpwYs5tpurLC+i5aN6/zkJG5AZlDATun47wHkGYEmuFdY
         XDo0gpi/DQRKjMaPD0g7Er2IJc4CYzKStv+05B5DUlPD6X+zIo2gu+F4uNXS8Zy27WJI
         V2FdMrMR/fJQleq5P9AsmDRrd9soqpH2u0BbStY65TKNQHgXPWkMeSX7MP878chlsHOw
         3RCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666194; x=1762270994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=do7MuCP88nOM3eMBQKiSZ63kBzTalMH1rd1ZJUZo3vk=;
        b=n1XI8i+Qrc9kWahaMSVQGpkzJ3PVYiTpEbKo05BEulVBnsyyc3RoI7seYCZdTZupgc
         X6l7nPwgs4palohF1tfe/M1UBwlmWoISlc0wF0AuoUdPlkF9Z6lJqGmQ3fTLWQns6cw4
         Ea+lhs8qE6zq1URXcKCil8OniTKydIFIbe37mI8b6+5YANzz2r/XieHs87N0t9TINpTE
         UIOF4vdmz88SYkzMNyfhvRlIYEbzgrRCJJAMa9Y4Rcaag3XWHi5x+Wnq5t/OyjFN1N7U
         IJu1vslLlGRKT4g5a++Cja0mRyzwVQI1+Xml+1sVns3Umuss08QoiuHvEi19ZfZi4yBB
         V9UA==
X-Forwarded-Encrypted: i=1; AJvYcCVeZ5JrtjOv2E1rBBIi07OOCBgyUZTZ03EavFKr6rIlZugfuMuyG3j4bcNfsyfMK3sOjH4lP3Ttyjf1THc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzulzqh5B/dYytNM3z2fjaOTagvZzwW4HYfwv0dFM9j/5Y89Zak
	aiI1oxB3mlecX98q1Wg8sp8/7vpFwyDLvEyiQFmvqKdHPZZXWmyDDe4ZG+Se9U4dxGfZosPjvJ3
	RaZSnDq3uywz0pxoAbqqi/pwDNqvgcbxkNH6SHvztNw==
X-Gm-Gg: ASbGnctrlQeVElp7fKygCLFhOs2rc5lxshgHib2a1jgqeztUoyfxtQNnFv4ODQTElNV
	CotFfO/NiEyJ2eUEDb08o/hUw5/PTX1MQw8Zz2hctbRerQ5yENwUss9dUxHflTY59AxMdGoum/B
	UdERtAvudAP+ktUwFq6feSj172vAKrQNRVLM8HC5mhtl4nG1ypSTIfvSkZyUSqHNUcTHkVVJXGk
	gVWvD35wTvHkL7Q/nlksvvUbzXW3m0U4KcZmbXxwTLHCuVwORmNQ4x+EwVlOPzEPoYLRfAi8y1S
	eSkzn0nh9KKIYhO0
X-Google-Smtp-Source: AGHT+IFTRBGcYDkiyCueyH65DwGrBfpjtYBktHnpsdJL9xh5HvsW1ijkB+8miiiXsCQ87IK4j3035BwnwPw7l+jO6Uc=
X-Received: by 2002:a05:6512:4027:b0:592:f766:a49c with SMTP id
 2adb3069b0e04-5930e997932mr1316517e87.15.1761666194042; Tue, 28 Oct 2025
 08:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org> <20251028-dt-bindings-qcom-bluetooth-v1-1-524a978e3cda@linaro.org>
In-Reply-To: <20251028-dt-bindings-qcom-bluetooth-v1-1-524a978e3cda@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 Oct 2025 16:43:01 +0100
X-Gm-Features: AWmQ_bmGdgwF3B9dB_VDDUnDofSCXpuNVCFm0vFH9VJDj6OZrO0qPdBbjuGlM8k
Message-ID: <CAMRc=MdqAATOcDPhd=u0vOb8nLxSRd7N8rLGLO8F5Ywq3+=JCw@mail.gmail.com>
Subject: Re: [PATCH 01/12] Bluetooth: MAINTAINERS: Orphan Qualcomm hci_qca
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:33=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> There are no maintainers of Qualcomm hci_qca Bluetooth driver, so make
> it explicit that driver was orphaned and no one cares to keep it
> maintained.  That's also indication for future removal from the Linux
> kernel.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8abdc0e50699..be637b9dc7c0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21146,7 +21146,7 @@ F:      drivers/net/wwan/qcom_bam_dmux.c
>
>  QUALCOMM BLUETOOTH DRIVER
>  L:     linux-arm-msm@vger.kernel.org
> -S:     Maintained
> +S:     Orphan
>  F:     drivers/bluetooth/btqca.[ch]
>  F:     drivers/bluetooth/btqcomsmd.c
>  F:     drivers/bluetooth/hci_qca.c
>
> --
> 2.48.1
>
>

Actually, I added that entry so that the arm-msm list can get Cc'ed on
patches. The fact it didn't use to, caused some regressions. I have
done some work on it, so I can take it over as maintainer.

Bart

