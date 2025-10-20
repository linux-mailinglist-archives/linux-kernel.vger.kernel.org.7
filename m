Return-Path: <linux-kernel+bounces-861623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42418BF3340
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3121886A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5792D9ED5;
	Mon, 20 Oct 2025 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJGO/Lg/"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C522D24B4
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988519; cv=none; b=IS/VDV1AJgdPdL6VURGsVQGAIfc8Gp95+ZgE0eIakpaZOSZZeY9OJVb8oLOvFXrO/E87R16LLvLSXwb4I+Sqegw6NyGor4NDRGJ3hInrgEQ6NF2JCmXQlCEqTNBH1CylTZ0kMqoaYcI7C2+nVIM8AWWHGTvcmkQZyxthqpQu4n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988519; c=relaxed/simple;
	bh=p7xYeF0WlMh71JeISQYSQHf2LpPiKT+ylBcdVGC2AqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGSSU4l0Sgm5ag/Si8hADQbgwwlI+MLdkqZPOOfYuJRUmCgiJqeoffn5QhiEOZ1ru6IxzgyA6cftI3la7c7zJXJDMpz0tp6kYUmaSzMORUJgB+WPkrOxeBfCRuqhtNFWE4SNw9CfEKM0T2fokaYK2Rm6pZVfskyG1uHTTHD1z5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJGO/Lg/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-579363a4602so4757826e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760988515; x=1761593315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMg83nd2YrTgwcvW3RZ6bW/OIA8b6kbsYQV4BXY32dU=;
        b=TJGO/Lg/3ZI93Doa2cyBSYdG6jGqWq5DvF/eqVzDpPPyMRBa6AD0YhzNX6Jd4wcAfA
         vsCuM3uiNUVCwqVJDiG8onEnDMq3gnhXC3i7sJuGv/JQ61TVrUcnRPyBvEy2hAmJyRwV
         ygZD2Ep/HAgDkZWgN8pIeclFa8whL6MXt9cCH9gAmXxoOOzETXTG2dfr3NkQfN17hrA8
         P2oIWCCVoPU4Fgq06zo5DNzQhUcg5Zyl7DzUMNqyzsaCSLXmjcE2kxIkczEjobnlHxaW
         WPImJXTGIUmsPXISTMrgoO7xZKATCaEDgVSn/GrsQWhBBoDaeB0PhYtbwynLVgt4nGvJ
         V39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760988515; x=1761593315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMg83nd2YrTgwcvW3RZ6bW/OIA8b6kbsYQV4BXY32dU=;
        b=NeGoA04M0P2luGmt9a6I7eVAw2AtTksQBoVOg9yxSVNyu5Itx52C+qrRKMJjiPlWi+
         t9Ei7lR2nsgItoFhOnQ90iKdoHOpHFkkUIkahGIvfjXamqk8GVo6Wvxbz6CuCx8Ungm1
         eDQMKfS+5zDBNZIBtVZMcmKjjO8UpCCqwv3YU6GJk6w69V8J6UgwQ4j10E5FSdAG6xOa
         s8kkM+ZnGuo6Irt2aebL+kot/eKyJ/mqoD5L1CHrelAXhlFzirnZ7vdNrMzHA7dNInmG
         zPQSrkokfYJ9P0L+VWx/fJ+BzrK7C5KCUrD6rY7tb2CCbuBB2kgWWQhIaJEnhEsjuSmW
         Q+zA==
X-Forwarded-Encrypted: i=1; AJvYcCWZDX5tFUfBmUDWjYwjzDRhrmSLY6+R/3V1ndGVgKJXVLngxzcbI/jiUQMzPuJzk9/goGLcos+bKpmCMzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVpMp30qx4O0dN4YnVCSLEO853g9JQAgsiNy8Ysn3Ifqc8Lccm
	Gfud6u/m2g3t6B1j3FQ4vamhLkztqmQbyCcK6jAWxv3Ou94PPy/T0FA1XLl5Wd0E4hqFeuQWwmL
	MucrNio4Q0/IUGdaDBrPsi/j+KT4ibNfdWtgm
X-Gm-Gg: ASbGnct726GUXf9KqCeQiZohGYNqgtVg4sFF69MlNFltn/1cTD7aHf/UBQk2V6LcdeA
	1z51bTAnfNiP0DtAEcklM/1G95TVq4yIxYWXKLVpTiALVht69bNxqgf08wxrqSACSMN6bQdM5AZ
	32nksR4da+53pUiaE/qFSbxazHCeya3CI0jfDvjDQmtcunxg52pu2C7GRA2HMcaSDXFS9hwlmpU
	9smYaqrwG/HXanDlCrNbDGGvHi9eD+D+2yxlb3Tuv9lEBJvaeGfiAI/zffthBXT4CyZZPVjDSz0
	TY1q+IZr0Oo1DEV0Ig==
X-Google-Smtp-Source: AGHT+IGBoVkVev7OLhVh5KiRwW/MZskLumEnnwL6WLxBkk2eAfCxIeEvBR17BmPX3b8GgUCopYGwgBk2P/JNXv/x5+E=
X-Received: by 2002:a05:6512:1307:b0:57e:b9a:9c82 with SMTP id
 2adb3069b0e04-591d85836e7mr4364166e87.39.1760988515325; Mon, 20 Oct 2025
 12:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250803-p3450-mts-bug-v2-0-6307125408c3@gmail.com>
In-Reply-To: <20250803-p3450-mts-bug-v2-0-6307125408c3@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 20 Oct 2025 14:28:22 -0500
X-Gm-Features: AS18NWBlNKt3MmTfiejt6ZGCRffbefMOPo_ko_DLqTSSs5UW2n7AtLASjfzoSFc
Message-ID: <CALHNRZ8ycMNA-OLx=hWNmetqxioDSbt2mRH=_NXr2zLu_pbJoA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] arm64: tegra: Add reserved-memory node to L4T
 Tegra210 devices
To: webgeek1234@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 10:14=E2=80=AFPM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Changes in v2:
> - Add patch for P2180
> - Link to v1: https://lore.kernel.org/r/20250526-p3450-mts-bug-v1-1-78500=
613f02c@gmail.com
>
> ---
> Aaron Kling (2):
>       arm64: tegra: Add reserved-memory node for P3450
>       arm64: tegra: Add reserved-memory node for P2180
>
>  arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     | 6 ++++++
>  arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts | 6 ++++++
>  2 files changed, 12 insertions(+)
> ---
> base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
> change-id: 20250526-p3450-mts-bug-02394af31f0a
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>

Reminder to review or pick up this series.

Aaron

