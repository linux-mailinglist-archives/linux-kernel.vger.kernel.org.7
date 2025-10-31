Return-Path: <linux-kernel+bounces-879564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E855C237AC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C62054EDBFF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8D830596D;
	Fri, 31 Oct 2025 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/JSzDqR"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216462FE07B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761893856; cv=none; b=HeTMTEkYWXuJX8WB6PfiCUFcrMXsP2xi/ZUkijQXqjCNU52uQiXEw1WIIkV1T1y2eb/u0ga5Nit7ljCnty7bGWcS4g7faJu5YFsvi8b81Yuaaa2IxnkriSLg9a90UTrHBJUAxJRtHn3ZmuUf4cqDdyIhXkxDJyhLtZJBe1oIVWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761893856; c=relaxed/simple;
	bh=ecDK9SnUGOo0Co29J89ja7/Hfoue5KPLe3vAHCwg4zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a18kWSTxZ2Xzeoea+qYs1IEEOenfk3gal0qKgmSnHUC5VcfgrRWu9e0Qp03zklfdB2Nvgo1h3CsBWYXdr5YbDrCLqSU6kIvkTH873CiecLgkNB2IY7Xsr1ZsKwASgGRNJvreEMngl9AUpBD1fkb/vT/Fa0rgOCz36rl+Guuom6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/JSzDqR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso3376036a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761893853; x=1762498653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hF/sVbbm9Ao9b8Ns6PIrso6umKYBwwEUA+RHQF/p8WU=;
        b=A/JSzDqRbjfKzcPqPgdPDQNN7w9Dd8ABFZnwKpqBE60E5zTtZALYm6VnFTiF5qJWKn
         3kwQKIzcjdl32dmaYVF3/fU8W1ZBC+NEZjj8ItvJb2LPKVs4jNcv4V8ytSmMBfYvukoR
         y8//olOfHc5l9vbwAOMiHb6KXz1a5bltE4D9pE8W5JjPqbsn3DyyQO0XxNKDTHzeQwc/
         EcNBsVTacHvrnkjmrjRK7M/9hprpQk0q4kE9Ex2m226XnRw7r/bDoeSRXeJh27bXijXL
         tyYjKz2WEthEpYdsrjiGpDvgv65c90+9ZIWHlHMkDsYV4lWFv2JDldy7vWgaxIIEcbKw
         RFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761893853; x=1762498653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hF/sVbbm9Ao9b8Ns6PIrso6umKYBwwEUA+RHQF/p8WU=;
        b=WOHMq/hi0PMVvcG2Zb58MPj9HrMo0mgso0Pkz3rQGNH17WMQb+P8ybw1hV0MInp8yF
         RoNLrZ/bI0Fh4/o4cdA2aXLHy+LhOSBd+p3FoUoS8BT87gPWEP7kQSMNLGHKTaPf2rKw
         Q5kkTiFoZbzn/BK6j2k+rfuZ+TeNhhwk0Qr6MIZYsS7dRsDuTIL6QjpTSM/vXgXnquv5
         KCktTCmZzvYyF0UnJ1JkLwX70otbsuIocgkf3WbeAYLd3ni5SLmVs/DLrEYh3vCki0yh
         qkUolh8pYhObYOsrfkIhj4l+4e3a+oHRA+yN8DVMNKlM54ksa7BVuBWE6id7vDssmZsf
         Z7lg==
X-Forwarded-Encrypted: i=1; AJvYcCW4rFw9D0eFcECvSc+19dUoQI4pFgbaZDap3le5wBRE+wA1sr2z3yaC50wiNf5KdjWAUSZHTK2Hx2b/nhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziufWJ/xEWB9thCA6vBMyF4hv6yPbe2Gm6eN8dXh/+dQCLtAbj
	BoF2/6xEkIQuBhW/kBup2yPRAyM3Z0LCw7j16SXBFEPED5qLZPpj+cul2EVbfJGDih2kbI/BURC
	tZrBvzKr2Cfa1rKY7HOTs9cpmkCklJ+4=
X-Gm-Gg: ASbGncsdcEqMrquuifqszHtOJiGQcpGgI1CoVFHrmk5ajuBPdhhDw8jjNP8mDmpZeM3
	jd41da5S1+u4rGUTnwC7qoEpMidbnUImna1EQNzsE2eKRA8GmdBw8UIE0ut7rA/ZPLAuV2lD2oJ
	2wYtHk2IHpgO8KTr+dVGkzWruUZ08mdlxx3Se04zOcYtdpEnxdd6Kftt7HFB4T3iWqVGf46Pm/Q
	s4Uxxpbb16yc4wBbYYfHrS1AtMXv5UyrdUaHu7/TKJCj284t1a4Y01LNr8s5ic9C//BFg==
X-Google-Smtp-Source: AGHT+IFyei+klT+e0zDZRYAQ8WfZ4bnVZVHTeB/u6lCn4sY3PNMEr1huxXolqGu7fMkBJJ2eI8cU2oPW7PqE/lfnbIQ=
X-Received: by 2002:a05:6402:42d2:b0:639:4c9:9c9e with SMTP id
 4fb4d7f45d1cf-64076f745edmr1865815a12.10.1761893853181; Thu, 30 Oct 2025
 23:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905112736.6401-1-linux.amoon@gmail.com> <176085588758.11569.7678087221969106036.b4-ty@kernel.org>
In-Reply-To: <176085588758.11569.7678087221969106036.b4-ty@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 31 Oct 2025 12:27:15 +0530
X-Gm-Features: AWmQ_bkdpeuvODAhvIaaZqDfiic9UVZyJJONFz6Rrfy4AXRXj22BM3Tny4odqv0
Message-ID: <CANAwSgRjXS4V_Kpw5kaJnPA8f=18uN-MgfEQ5ErN3aFRqbJKfg@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: dw-rockchip: Simplify regulator setup with devm_regulator_get_enable_optional()
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Manivannan,

On Sun, 19 Oct 2025 at 12:08, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
>
> On Fri, 05 Sep 2025 16:57:25 +0530, Anand Moon wrote:
> > Replace manual get/enable logic with devm_regulator_get_enable_optional()
> > to reduce boilerplate and improve error handling. This devm helper ensures
> > the regulator is enabled during probe and automatically disabled on driver
> > removal. Dropping the vpcie3v3 struct member eliminates redundant state
> > tracking, resulting in cleaner and more maintainable code.
> >
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] PCI: dw-rockchip: Simplify regulator setup with devm_regulator_get_enable_optional()
>       commit: c930b10f17c03858cfe19b9873ba5240128b4d1b
>
I am looking to suspend or resume the issue. We probably need to
toggle the regulator
to maintain the power status on the PCIe controller.
Therefore, dropping the patch is an option; I will add dev_err_probe
for PHY later in the patch.

> Best regards,
> --
> Manivannan Sadhasivam <mani@kernel.org>
>
Thanks
-Anand

