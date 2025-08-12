Return-Path: <linux-kernel+bounces-764487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94789B223B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F47D5003B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1EE20C037;
	Tue, 12 Aug 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Map2H7XL"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA52D59E3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992201; cv=none; b=ioXU39CyYHY1eLJnM/5oE2hoeD/yV1RAcFUAFPAWLZ0PEfftCzyIxikdE2DYmfdzij0GV05B4S/EoMEvdVM3HaX6a5KAg16SdP8EyufDwxvgReGtkWulvp7tNJnjLF4dcWFtQghSiO6CDNn0lZ+MIKlmjVzaKdcgAAZTdSd1wn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992201; c=relaxed/simple;
	bh=0490oyMMcCSA6IAYKsOOlTvkHGvUwxMFO7SMFhwwTEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWg7MSgJ967swRuTWarFI/gcnb0zTxeUWVrRDbuWTYTMW606iR2oCB7i1Ndtd5fTIblUj/Rx0x2TgNymcBAKuKRvyL14xqNoCKUpN9ztjam34RlTCu47E0yoi8/aelmxKLaDLd8Go1LiI2BD4nHb5tRc5bt23wt4hAK9FmN0TGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Map2H7XL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b42254ea4d5so3441687a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754992199; x=1755596999; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rHx6Lde4qag7Ztq8SOjvT6+8sJ05xOxFR27nxsVwgtA=;
        b=Map2H7XLyX5tAhnuBljyVK5gOENCd/EFkAAjRUiix4f3fE2IA4HYRcT0FY7MjwuFsH
         MBcEoUDadpXMRudf01gQo1K9S677BwmIWc4jhirjNZFbjKnVhQVvrw+DL9Xgk9jUcHpY
         QH3BxUQsu37C3KVsf6d8SI6hysrrryrQ91Zcxudj2jtIF7CORWKR1aV1B/SARjwm76Ek
         c/mIOtKhQ/DnD0pMOw14GKRLNt/LHoz3mOvae+ZSl5HhPfMIPRx+6vs068NBvVcmAOX4
         mE8CdDYcSCpskV0pTYUVnwTsCM0qdG5FpGLRJSilNIh2JH+SmAnmRKI4QxirDWGOJ8hZ
         QbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992199; x=1755596999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHx6Lde4qag7Ztq8SOjvT6+8sJ05xOxFR27nxsVwgtA=;
        b=GJTN0zqrXySQ8t2+p1Amazt/eZlFoF0ktHKZDRlvMfheei7xe/kcPfHRZztj7Ho72o
         ijJtXpubQlvpL13DFFoBuXEMCLXb9pJ7cm4rEC/ezX+MjE6quscvczsr2BqrHoLmAeUb
         x7wS15w6+e1pG/frKBb8/VlFaz+XHsL+GQLeCHQB7xFDAA3V94E4ldE0xf8uv1v2LnHg
         KANNNEDx12q7GNvNtH1310MWOFZpUgQRu3/N8rYSTnXyf3vEw5AbMMvBbtzlYp3AnxMm
         eHQjey75Ntd9Ct82F9xLPL5f4m59lfm93JZg0X1ehOd8I2Z7agJSv6aenhAjSi1KjJ6s
         1vQA==
X-Gm-Message-State: AOJu0YwRxqZBwK2HjDyzMAfP72WgO3Go9ToiRDZj0hRESEnAhSm7BQzu
	3N/VozCG54zNsLosngv0rK1jcAlhPkmNIRGU4lT2HougE6pmrOpjW+rdwtdtLn3iTng=
X-Gm-Gg: ASbGncvpVfNETABz3nB3WWvM4ESSuixYqXKw2lO94KQwrk5YkDqe6Sw+rC0RtKb9hRa
	nN54WdI/YINXHrnravMRGARhtECxXGB0XJLOMvd2P6CSHXAZfbVzmTJI3Xv3NwLeF4cRq1tU6HC
	YTUpRhONyxCk6pm++2d5XQiErZTxxtbdd6lroKPR3TkhO2y821r6sSQ9VGOU0FkzwjydWysjTth
	k3C5/XsqPb2+kr/CEBT55D5MoqO5U8lCu8+CfDjctb3JQMLzzkUG2xLB0yNcXnYqIHTHUQGqYid
	8PNwjrmQ9kHT5JngD4bas41Ko5lC4e5WROhW1SOXie8Br9PMkqGaYciq2JgXu4oBAAaxSxuXr2T
	8l7V0KdyGw5ZT5LT/2ldFo8Ys
X-Google-Smtp-Source: AGHT+IFaE9wVmVALZ0AY3vMXxmm7SesZjwR/ULKy6XjkkdnNRyUoc7TfxGfX3avMzoLT05C0xMUULg==
X-Received: by 2002:a17:90b:55cd:b0:312:1c83:58e7 with SMTP id 98e67ed59e1d1-321b3e81bb1mr7812400a91.1.1754992199185;
        Tue, 12 Aug 2025 02:49:59 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7d86f7sm24860991a12.24.2025.08.12.02.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:49:58 -0700 (PDT)
Date: Tue, 12 Aug 2025 15:19:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, Sudeep Holla <sudeep.holla@arm.com>,
	Bertrand Marquis <bertrand.marquis@arm.com>,
	"Edgar E . Iglesias" <edgar.iglesias@amd.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [RFC PATCH 0/6] virtio: Add support for Virtio message transport
Message-ID: <20250812094955.fdyil4cbxr3bx4bo@vireshk-i7>
References: <cover.1753865268.git.viresh.kumar@linaro.org>
 <CAL_JsqJn2XtvWaDBSqYPUe2ZVxE7t4EbAt8OPncbQaKjh1jY5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJn2XtvWaDBSqYPUe2ZVxE7t4EbAt8OPncbQaKjh1jY5w@mail.gmail.com>

Hi Rob,

On 30-07-25, 08:39, Rob Herring wrote:
> On Wed, Jul 30, 2025 at 4:29 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > ### Memory Mapping and Reserved Memory Usage
> >
> > The first two patches enhance the reserved-memory subsystem to support attaching
> > struct device`s that do not originate from DT nodes — essential for virtual or
> > dynamically discovered devices like the FF-A or loopback buses.
> 
> We support creating devices from reserved-memory nodes.

I didn't know about this.

> Just add a
> compatible which you should do anyways because node names are not
> supposed to be that specific or an ABI.

Yeah, I already knew that the node-names thing isn't going to fly as
you and Krzysztof rightly pointed out. I just wanted inputs from you
guys and so did that as a first implementation to get the discussion
started.

I tried something like this now:

      reserved-memory {
        #address-cells = <2>;
        #size-cells   = <2>;
        ranges;

        rmem@100000000 {
          compatible = "restricted-dma-pool", "virtio-msg,loopback";
          reg = <0x00000001 0x00000000  0x0 0x00400000>; /* 4 MiB */
        };
      };

and this works fine. I am adding two compatibles for virtio-msg:
"virtio-msg,loopback" and "virtio-msg,ffa". Yes I will properly
document them in the next version.

With this, we don't need the 2nd patch anymore:
  of: reserved-memory: Add of_reserved_mem_lookup_by_name

but still need the 1st one:
  of: reserved-memory: Add reserved_mem_device_init()

Thanks.

-- 
viresh

