Return-Path: <linux-kernel+bounces-875234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F7CC1880A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC7775633D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA38A2F619A;
	Wed, 29 Oct 2025 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2v0awYy"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9BD20B81B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761719398; cv=none; b=FUerwtirlRWMYkfyfi3cWyv7uTwdiW6lWnHol+ywttH0nB4eBZLpZDuYrka0F13536bVWtymNaqPs0ET7u6HmRicKqX70b/9xLNDEqQlZPV0GElvgtsL3Ga3ZjiR1CSi7Wc2/eiKErIm3KO3YOsM/OzJEm0QUQNpLF+g9xJ5xvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761719398; c=relaxed/simple;
	bh=kicBV7oIuS5DOwkjSIlCZ9hu2/48zXNrTZNbiv8Kemk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlilbQenFPgfH8aAt9WSb6EUFfLY/nSA8BWB3IM8ALPpzmWoobge8b/t1s70ZrpaLVtYoWD/RqGTiYw+84zd12ZulMdqIhjT/PEKaSWsCZTdbA63wYoXEqK9heP4AnEoAQRY263Igg3ewnfDBC5kaDHLa1HBmr8JVfgX5/uFDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2v0awYy; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso14563062a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761719395; x=1762324195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uMONH+8GVOxyEjApROS3jg17q6oAv/cnPEMuimC2yEw=;
        b=Z2v0awYyw58Jtve/dcpJqh0rgNk/vH2V9iUFa+cjuSMULYPHwXYNvh7RzS/1wp8BZf
         4rZ78d12XvJywPZz1fyG3TnkhVkFEDNilqdKemF4gIg57FCIXIO7Hq/LC7GdL9/e7Pdk
         g4n/Ax8JMKeR3TKBkOZ55anskR+Bd9rc+ZPfBrIJ6300ndA/gX7ORAV0sHaMcLQhl0oV
         UCPb07N7br1/ymkVmC9AhEvjWA8ynySCezff9Y0wBqD4fIRyrD3m2jpK4rc+kl0/IOor
         85zXm9aEz9+8UPk2x19p7ZLBu0bq76rROeFxeYPK6xSbV2pZcVxANhh/fA/Mdqz2Dli6
         hMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761719395; x=1762324195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMONH+8GVOxyEjApROS3jg17q6oAv/cnPEMuimC2yEw=;
        b=bC4P7V11/yyghsEXy4k04+huGGnfNpaD+jqHj3A003KuvgF1p9bj09BzDETNODscY+
         xeNpQ67kn003FL2PZUMSfHlOahK/8LkieivxJXZ8PenK9evwGW13JlSBkQ5oYEI63Fnb
         YmqMRDOid/4YK7ZKbAI0CEF7JGVHguvxHj7bTAo18GujOoBX8LCvLGVA1r/Ctvh2T/jw
         W7YCpuei4cNMnLgKNIRmHi4zdaGJpS3hEO4oKp8fdre8+v8wMW63cVf8kUoVIzipbZmi
         EmmjOidzUs0z4DXfCIZKr0Vg6PGSeuk3kRrQYr7IVTJK3JMHDYrg5tKriElDaDIpks6M
         E6RA==
X-Forwarded-Encrypted: i=1; AJvYcCXQWyNA31Iq5QVWiCh+/Q6kB/oYWeIx/JrLIdisaeO0rBl7JbXbiQR9INyBQb2sm8yQ8ISP6FGM5ExB9gM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8pVP8HdLgERo/IuzT9bfqo+vVIQ2tEFwJ7BUyLtsRXzbijrmY
	vJHalNRYxrPU5desla2KgWdAmYbRMUokElR2LlRH1JUZDG+rE0VI9DnUqiNRtSrLt5A3gTLwgq/
	WWdFSfSKgi8+VrCzeoYECF53CjyhZCFk=
X-Gm-Gg: ASbGncvEIag3zmI4lkO6u8lcCOoVWs7Njis3YJOxqT0nW4kHhOnX0/2wbwnUpxT9vtf
	fH32I+jjqiE6aMqx0cX2E2+8qlGb6hGn7ean45yHsr/MPWGV8XZfDV/rTqg4uQn/2PXeQrDAHqK
	HbreenyyQpM9/IkdmU3WEv3xKhvd6Qnpx5svq17sVyLwizBhXEWGe9xHqXQM6hsMGaw4biGJwTD
	M/zaDnA39xSD9AjC8SOpOR6BIUqhFSi3/wLs0TfwAWkbYhJu1S8xl97OW0DLC51gK4S8w==
X-Google-Smtp-Source: AGHT+IGkpMP2JV93jKtrqYcUv2doQVUVgTWnNctMEjS6Xs0nmKSaC8SY+NE+YO+7RTCK8H8Slnh23fd4/D0WvABiTU8=
X-Received: by 2002:a05:6402:26d3:b0:63c:1f3e:6462 with SMTP id
 4fb4d7f45d1cf-64044251e38mr1273131a12.23.1761719394933; Tue, 28 Oct 2025
 23:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027145602.199154-1-linux.amoon@gmail.com> <5264377.31r3eYUQgx@workhorse>
In-Reply-To: <5264377.31r3eYUQgx@workhorse>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 29 Oct 2025 11:59:38 +0530
X-Gm-Features: AWmQ_bkhkw-pZtArjJD2gcBzKDEhehQeURBZRDtuYYptEbI6fqoAKgnKeMTW7xw
Message-ID: <CANAwSgQts0B2Sq0V2psa53WzTLEdU-Z=jkqGkW1ESmvKf_6EyA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add runtime PM support to Rockchip DW PCIe driver
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Nicolas,

On Mon, 27 Oct 2025 at 20:37, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> On Monday, 27 October 2025 15:55:28 Central European Standard Time Anand Moon wrote:
> > Introduce runtime power management support in the Rockchip DesignWare PCIe
> > controller driver.  These changes allow the PCIe controller to suspend and
> > resume dynamically, improving power efficiency on supported platforms.
> >
> > Can Patch 1 can be backpoted to stable? It helps clean shutdown of PCIe.
>
> You can do this by adding a Fixes tag to your patch. In your case, it
> might be fixing whatever introduced the clk_bulk_prepare_enable, i.e.:
>
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
>
> This would be put above your Signed-off-by in the first patch, after
> the empty line.
>
> To generate fixes tags like this, I use the following pretty format
> in my .git/config:
>
>     [pretty]
>         fixes = Fixes: %h (\"%s\")
>
> I can then do `git log --pretty=fixes` to show commits formatted
> the right way. To find which commit to pick, `git blame` and
> some sleuthing are helpful.
>
> With this tag, stable bots can pick the commit into any release
> that the commit it fixes is in.
>
Thanks for your input.
I will leave this to the maintainers to decide on this.
> Kind regards,
> Nicolas Frattaroli
>
Thanks
-Anand

