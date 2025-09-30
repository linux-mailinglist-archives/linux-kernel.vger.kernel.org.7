Return-Path: <linux-kernel+bounces-837561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 181E9BAC943
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1933D4E1F79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34212FABFA;
	Tue, 30 Sep 2025 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGfxW3Tk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52B275AF6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229952; cv=none; b=KD2fa2WhVol5ZKw7AwsqhIZT6WW8cr0UY/xs8kVQzbczgK85pwWFbEVP96ElXjfp8WgBEkJMnDF7Cy944tLw34fBd6jbUygNsxSysOpdfgsuAwpNlP9F26MBBG2ZOF0xlLU0ZMkIxMc5IBSeYXsV0WANYh59V1BJCLq80wp3JTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229952; c=relaxed/simple;
	bh=aD5jGL56V2tce4m9N5SJnlY9Yue0hnBtWnJ3rC2zM6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzAxZRH1e+KvG3VNVcqwsUWVeAx+8J2IJLJ7/x6KGlfvXmwmwcG8dOGILjPGYfrqbhEEEU4JG7enENjndTGsecp5JpR0003/BtZuYR/7GvqQODYiraWqhSf/CXSVOvGVnYSQGXZmNjzXeC2RJYgZvv0QWJ+z9xL+yDH7OA2l7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGfxW3Tk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759229949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVOA0Q0ymTDoBZOCl3mOf8HuY6BSBntN7jY80MGvrho=;
	b=YGfxW3TkKDx4jsZBZdCGT2UhLyGP9S3Y549+LvNki0jNZoCEv2Wma9MtnXUj2814owLEBr
	yl5Pqy9vkm8z1B39Iy6gPH44DafRhhraniG4pl44Fo28GdQEPSkqw55BaXrOssmph+jGwy
	keAIHsPSnK0wnWNoTqEoR+ndHSpsr/A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-lbPyCVS8MWaFHauPcwr2fw-1; Tue, 30 Sep 2025 06:59:08 -0400
X-MC-Unique: lbPyCVS8MWaFHauPcwr2fw-1
X-Mimecast-MFC-AGG-ID: lbPyCVS8MWaFHauPcwr2fw_1759229947
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3e177893so36104925e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229946; x=1759834746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVOA0Q0ymTDoBZOCl3mOf8HuY6BSBntN7jY80MGvrho=;
        b=eU1gxAoAH++YhUiwrOt1lnMUPuymFMiqabkZlzwAd7pi06rT6c5GhmXc05xIvwuwWo
         JO7KPH0Kl+QqU4jDRs7DP8yLV6dwGmsaeg67jROYOx9FklIONejkkloMSxofUd+pXGA/
         FA9aaEaVeeXah4M6GCT+ci0h/9LWpybvu88Oae1kAgxM7QOQ41hBaiRZImJoVZ5Z+kD2
         HkIyFpiYHUx2Az5v0mXpBCk3n+wjd5ifJtAt9lFIsQJ5FDuF3q4TNa8AjpBU5HGdv/Os
         IUckCSHU3XEyoY6OrqBRsyzyCA42oLZ8UJyBa4zh298SPvkrF9LTSMs5qQrLG8vAliYh
         3aiw==
X-Forwarded-Encrypted: i=1; AJvYcCVe6JHorsyKFmfFq+yFk3AgZtvKpM8glEfvzy/as5bxSnVSlbJDY2r365q0moli8sbkjXZxV6cOQWGJq+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjsZPfuK3syYwr1hJQ2AVP4WJ/lgUIuRVXGioR25ND2g0NsAe8
	KyzHglKMgDiEDwCSMrggOHimrcT/Mk5PT2n0LGZPPunewq4H1FgtSBeyLa0ZpVbv5d1xuWdhltm
	3e875DThrtoOFuJ4Mv9vOM2cFTJmBjG2u6gMS4Inz7+q/NIQsscmepD3X4m61lbeHDh9WrCV7nQ
	==
X-Gm-Gg: ASbGncsAjJfQtu8X34sKUht3UahUcGoPbcXaXNFN1vofyU7640ZXS6xPzLX7veZtLHd
	OLOs/rrmaJ45/L0xeFe7Be9Opq3AJ1meJYkAiNQYMlaErofgN4xnCa1osbWLc/RtGd9es60/mgU
	Ra9Ep+sHAdHRNiwtUxCn1krIg4cAbUkmnDzgDBfFzuw6oLumGkqlKUPAb4zlnOrrS6Gh8Xjb4wh
	EYRD4v4jYWbBigyeXvjMQVMLmyYW0gj9c/lDKDIPw+Rc1B48jn5mbuPzbrcB1OEkZFSVQgOFWD9
	pTahkfg5oZ9ExCI1EPYAd3jevlNlWGgP8iw/331wsdp/0CCFe+ftuJ+fhwuQHGv/BL19jFGcM7/
	cikW/7JHD+twN4KpWgA==
X-Received: by 2002:a7b:cd98:0:b0:45c:b6fa:352e with SMTP id 5b1f17b1804b1-46e329fb852mr152040245e9.18.1759229946546;
        Tue, 30 Sep 2025 03:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl75M5KM/nmhV85NmfLdPrO6RTkSlsYl+oX9QrpyA/JV+GEDplaQbfuu86mibd2UCwjkweEA==
X-Received: by 2002:a7b:cd98:0:b0:45c:b6fa:352e with SMTP id 5b1f17b1804b1-46e329fb852mr152040055e9.18.1759229946107;
        Tue, 30 Sep 2025 03:59:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab61eecsm263007585e9.20.2025.09.30.03.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 03:59:05 -0700 (PDT)
Message-ID: <b92d752d-b4c3-4f3b-8a2b-1c7162af63b7@redhat.com>
Date: Tue, 30 Sep 2025 12:59:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 2/5] net: phy: introduce
 PHY_INTERFACE_MODE_REVSGMII
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20250926135057.2323738-1-mmyangfl@gmail.com>
 <20250926135057.2323738-3-mmyangfl@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250926135057.2323738-3-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/25 3:50 PM, David Yang wrote:
> The "reverse SGMII" protocol name is an invention derived from
> "reverse MII" and "reverse RMII", this means: "behave like an SGMII
> PHY".
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

My understanding is that Russell question on v11 is still pending:

https://lore.kernel.org/netdev/aNbWEdabqXIaoo2T@shell.armlinux.org.uk/

and the net-next PR for 6.18 is upcoming. Deferring to next cycle.

Cheers,

Paolo


