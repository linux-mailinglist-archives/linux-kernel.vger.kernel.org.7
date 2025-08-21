Return-Path: <linux-kernel+bounces-779167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAA6B2EFED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9709DA0435E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D62F2DEA7B;
	Thu, 21 Aug 2025 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="paI360l2"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156E2BB1D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762048; cv=none; b=DTZAycIUhFFvQZc49FlDvlKPZb+NCsTRNSQbWX5SstjCYiFt8b+E3zTcfiKJYs/Z6qHJsdGEmJU1xWsySg6MyyOWOEzbPhuLuFYtqa4FvmGYjr7aqXJaHw3Rr4ZfvfZl/ByqCLhzj1iV98YLY6w7fAbRZ0BSY7v0a9fWW6vUatQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762048; c=relaxed/simple;
	bh=Uj3lhiNQ8KTr4No999KBtD5ZsLbjQ3f79sUlJDHS0tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFpYWP+od/D1IWGLrbAh8pBEanwOzYKflS5EfdScFjby/JtTEdPNWTLM/1SPjWNGuv5ICjOo6re6YOTWEUimnTC2VSgYT20vEfDMAlTgtXxjYJgZhCoXpxmU5C09J/s1AKFV8o/7aJ8Z1BzA/FUVat6S90nsmzUODfV5g+w4iAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=paI360l2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7347e09so119753966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755762043; x=1756366843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOmX8DoVDkdi25dNPPFg/anGS8Ls6i4vihgyINbx3eI=;
        b=paI360l21SWhZYekRBoBldNtbNlggtjTEkV5yobCx2NadeoBa9xSBwXClqKI7zV9Zx
         nEdNZ779qCpmNO4SspzhzPJvD+pJszCwTv5109KY+ulHiKCKpy56jPFMvzvhImHvfYqh
         j+x77tPi+4j8VqsWgxd9ujlTX6XL6SpNgW5DPFHX1UCwT/9FqhOT+CTTOQmXoxrCbciP
         NDBqBXPt4OR6yEp4DYqRIT/KDttkWZpMCNOh5iC4cvsl1s19yZMDckrGtJh1aBNTQQ0u
         zt3VEFEGZH6hMEV5lMB9NyWdojju3SdSeCTqzSWyrMd4JA9P/XeQcyMLgJq+WcS3PcKn
         yeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755762043; x=1756366843;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOmX8DoVDkdi25dNPPFg/anGS8Ls6i4vihgyINbx3eI=;
        b=M1x72JdW4n9oONLD0obpM8mvaNN+4yqi+G44HjSsLgUku+QtL8UOM8f+Fd31Rv8lw7
         FFJBWNZg8ncL2aaTVNKSAXUbra3O0Td5ms2eDPAKS95MgKw6KywI/W0nwhUtc8JtwSJ5
         cBt5CKJU1VsM/9pqhA9v/HzCylSOpBlIms2+ZKFV7LXFqnZPEw/a4+8ObtY3VzAsb9AM
         N08SGYZ6R9/HbNDFxFV0gt9lOnW5QJa0iu34HNYp7bk3zlbKl4DLwqzpNxZwOxJS4SAB
         EdMRBpRKihzgyI3+qjQ3pLDi43wnMXt6W1lqvVX6TyefB6IIglFaSMegVOoOIvVOuyCQ
         Kt4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSM3iwy5WyVGfFNHrNYF57c1bm1JIbQQ6FzmZXAppcIFRT0qhRPEhAG9ZjAi73zglrbI8JwN8BdZj9miE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/WKNL2GKrbLA9nVIi1zqJwe1EXimrBSPmEl3CAPeomNepW7Tf
	xLTjWPNR5Niqpab3WV/5xNvGdSSkzFMLAuqgYtDrA8Q/u/ls/bhwb6qcv2ylRpYRZKA=
X-Gm-Gg: ASbGncutytD8jTyHMoFXAv54RS3+U8RE+hEO/eSMZd6hhzSJut5VdVOAzG/OsIB68jG
	dLCCxUq2z7XKHwnxuw8GCvPkSTYplWIdppf7qVRJIeVi+VrI0L3NbvvHJ4137y0Uzzzg9/n1UrL
	8rAerkn2raN983X2iPdPBzXf1Gr8NayMVkEEGBHt5ppTAS/ohf4RMYaAz3EXboTfbL4p0zQj36R
	lLeIjYVr21vHYYc6odD1ZMOIC3eWJH+Lzv9DSfrECrbq7aDFulgUESdwJSPgvTHZkOgtD2O1V7P
	/WRrWfp8Z+Hyw6DM0tGeAfO1QpENIkXLRhqSZUGnvv9OcO2vE359tAuOV7hPg+VeIWoir/gr4iE
	9HzIaJWL5Ycotl8Hi0tP08Se3ow/MGQ==
X-Google-Smtp-Source: AGHT+IHEJwqxJwdifUOCSxwxS8LU3s+6tTaEhqmWIZcz8WNrqBZn4cOf5NK2eo88RGZk0Kt+NV58dg==
X-Received: by 2002:a17:907:3e89:b0:afd:d9e4:5a4a with SMTP id a640c23a62f3a-afe07d61255mr154660366b.62.1755762043006;
        Thu, 21 Aug 2025 00:40:43 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded309f55sm341039666b.47.2025.08.21.00.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 00:40:42 -0700 (PDT)
Message-ID: <d004d9c4-f71b-49e6-9ced-031761f5e338@tuxon.dev>
Date: Thu, 21 Aug 2025 10:40:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] PCI: of_property: Restore the arguments of the
 next level parent
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, catalin.marinas@arm.com,
 will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 p.zabel@pengutronix.de, lizhi.hou@amd.com, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <20250704161410.3931884-4-claudiu.beznea.uj@bp.renesas.com>
 <7wmpgldjvznbllotblv6ufybd2qqzb2ole2nhvbx4xiavyqa2b@ezaqwghxmbve>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <7wmpgldjvznbllotblv6ufybd2qqzb2ole2nhvbx4xiavyqa2b@ezaqwghxmbve>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Manivannan,

On 20.08.2025 20:47, Manivannan Sadhasivam wrote:
> On Fri, Jul 04, 2025 at 07:14:03PM GMT, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> of_pci_make_dev_node() creates a device tree node for the PCIe bridge it
>> detects. The node name follows the format: pci_type@pci_slot,pci_func. If
>> such a node already exists in the current device tree, a new one is not
>> created.
>>
>> When the node is created, its contents are populated with information from
>> the parent node. In the case of root complex nodes described in the device
>> tree, the created node duplicates the interrupt-map property. However, the
>> duplicated interrupt-map property does not correctly point to the next
>> interrupt controller.
>>
>> For example, in the case of the Renesas RZ/G3S SoC, the resulting device
>> tree node is as follows (only relevant DT properties are shown):
>>
>> pcie@11e40000 {
>>
>>     // ...
>>
>>     interrupt-map = <0x00 0x00 0x00 0x01 0x1f 0x00 0x00 0x00 0x00
>>                      0x00 0x00 0x00 0x02 0x1f 0x00 0x00 0x00 0x01
>>                      0x00 0x00 0x00 0x03 0x1f 0x00 0x00 0x00 0x02
>>                      0x00 0x00 0x00 0x04 0x1f 0x00 0x00 0x00 0x03>;
>>     interrupt-map-mask = <0x00 0x00 0x00 0x07>;
>>     interrupt-controller;
>>     #interrupt-cells = <0x01>;
>>
>>     #address-cells = <0x03>;
>>     #size-cells = <0x02>;
>>
>>     phandle = <0x1f>;
>>
>>     // ...
>>
>>     pci@0,0 {
>>         reg = <0x00 0x00 0x00 0x00 0x00>;
>>         interrupt-map = <0x10000 0x00 0x00 0x01 0x1f 0x00 0x11e40000 0x00 0x00
>>                          0x10000 0x00 0x00 0x02 0x1f 0x00 0x11e40000 0x00 0x01
>>                          0x10000 0x00 0x00 0x03 0x1f 0x00 0x11e40000 0x00 0x02
>>                          0x10000 0x00 0x00 0x04 0x1f 0x00 0x11e40000 0x00 0x03>;
>>         interrupt-map-mask = <0xffff00 0x00 0x00 0x07>;
>>         #interrupt-cells = <0x01>;
>>
>>         #address-cells = <0x03>;
>>         #size-cells = <0x02>;
>>
>>         // ...
>>     };
>> };
>>
>> With this pci@0,0 node, the interrupt-map parsing code behaves as follows:
>>
>> When a PCIe endpoint is enumerated and it requests to map a legacy
>> interrupt, of_irq_parse_raw() is called requesting the interrupt from
>> pci@0,0. If INTA is requested, of_irq_parse_raw() first matches:
>>
>> interrupt-map = <0x10000 0x00 0x00 0x01 0x1f 0x00 0x11e40000 0x00 0x00>
>>
>> from the pci@0,0 node. It then follows the phandle 0x1f to the interrupt
>> parent, looking for a mapping for interrupt ID 0x00
>> (0x00 0x11e40000 0x00 0x00). However, the root complex node does not
>> provide this mapping in its interrupt-map property, causing the interrupt
>> request to fail.
>>
> 
> Are you trying to say that the generated bridge node incorrectly uses Root
> Complex node as the interrupt parent?

I'm trying to say that the generated bridge node is wrong because it copies
the interrupt-map from the root complex mapping int 0x1 to 0x0 in the
bridge node, while it should have map the int 0x1 to something valid for
root complex mapping.

E.g. when some device requests INT with id 0x1 from bridge the bridge
mapping returns 0x0 then the returned 0x0 is used to find a new mapping on
the root complex based on what is provided for in with interrupt-map DT
property.


> 
> I'm getting confused since your example above shows '0x1f' as the interrupt
> parent phandle for both Root Complex and bridge nodes. But I don't know to which
> node this phandle corresponds to.

Root complex node from this patch description has:

phandle = <0x1f>;


> 
> In any case, since this seems to be an independent fix, please send it
> separately.

Yes, once port bindings are added this fix is not needed for this driver
anymore. Will post it as a separate fix.

Thank you,
Claudiu


> 
> - Mani
> 
>> To avoid this, in the interrupt-map property of the nodes generated by
>> of_pci_make_dev_node() map legacy interrupts to entries that are valid in
>> the next level interrupt controller in the interrupt mapping tree.
>>
>> With this, the generated pci@0,0 node and its parent look as follows:
>>
>> pcie@11e40000 {
>>     // ...
>>
>>     interrupt-map = <0x00 0x00 0x00 0x01 0x1f 0x00 0x00 0x00 0x00
>>                      0x00 0x00 0x00 0x02 0x1f 0x00 0x00 0x00 0x01
>>                      0x00 0x00 0x00 0x03 0x1f 0x00 0x00 0x00 0x02
>>                      0x00 0x00 0x00 0x04 0x1f 0x00 0x00 0x00 0x03>;
>>     interrupt-map-mask = <0x00 0x00 0x00 0x07>;
>>     interrupt-controller;
>>     #interrupt-cells = <0x01>;
>>
>>     #address-cells = <0x03>;
>>     #size-cells = <0x02>;
>>
>>     phandle = <0x1f>;
>>
>>     // ...
>>
>>     pci@0,0 {
>>         reg = <0x00 0x00 0x00 0x00 0x00>;
>>         interrupt-map = <0x10000 0x00 0x00 0x01 0x1f 0x00 0x11e40000 0x00 0x01
>>                          0x10000 0x00 0x00 0x02 0x1f 0x00 0x11e40000 0x00 0x02
>>                          0x10000 0x00 0x00 0x03 0x1f 0x00 0x11e40000 0x00 0x03
>>                          0x10000 0x00 0x00 0x04 0x1f 0x00 0x11e40000 0x00 0x04>;
>>         interrupt-map-mask = <0xffff00 0x00 0x00 0x07>;
>>         #interrupt-cells = <0x01>;
>>
>>         #address-cells = <0x03>;
>>         #size-cells = <0x02>;
>>     };
>> };
>>
>> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v3:
>> - none; this patch is new
>>
>>  drivers/pci/of_property.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
>> index 506fcd507113..8dfed096326f 100644
>> --- a/drivers/pci/of_property.c
>> +++ b/drivers/pci/of_property.c
>> @@ -243,6 +243,14 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
>>  		}
>>  		of_property_read_u32(out_irq[i].np, "#address-cells",
>>  				     &addr_sz[i]);
>> +
>> +		/*
>> +		 * Restore the arguments of the next level parent if a map
>> +		 * was found.
>> +		 */
>> +		out_irq[i].np = pnode;
>> +		out_irq[i].args_count = 1;
>> +		out_irq[i].args[0] = pin;
>>  	}
>>  
>>  	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
>> -- 
>> 2.43.0
>>
> 


