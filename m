Return-Path: <linux-kernel+bounces-734694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBEEB084DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8CF3BB154
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E17215F4A;
	Thu, 17 Jul 2025 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ekMwIdBf"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB4919D09C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733637; cv=none; b=KHb2l2pHmJd/Mmfcry484eE9clKnZC/PjK4EbflSfZg7i6LGP5AwElwwdjtjuhOnKfvwxwSZbyPidbyfYTkhyYibOd6Bifb6HWg4ztyVyPcUnZSQyeUEfwZKipYixE55cu6FZAWhIipat6iiGSXDHG3J1ihx4ghRImSkTVIezxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733637; c=relaxed/simple;
	bh=OwXzItnnsraIcYnVt0zgQl604aTargDqKQyzSiybBRA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=n0T3UkY7e0KQLNFCoXrAb5oSAyRxpjaI364Rz3+ehKD1BhEC2JiKQGQxIUvv83JJI5AsEs7SRrASZtvK0LVbt2H05wg+ed8IaMlrb97NXki7OQ3wmRJCqiS+J97oS3Ob3p6ideMlkD0knvsU4zWuoYAoq1uVDd7eYLcbfvBARQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ekMwIdBf; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ae361e8ec32so101857366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752733634; x=1753338434; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMULLTVpVqv7dK7IgKD5UscRXMfGKKGocHzIjlBduJg=;
        b=ekMwIdBfRqT3Cl4PfmI2InsnINddZmMiV6KE4fN7/M/X5dXq81gEspq05a7L31JHOM
         izR9n5uYlOW2OGG1MZ72wNQUXmVq1HMd7ZGLpzI8vxBsha/IKPQkDadC4vU4xeUbdjnc
         a00972zikT/C2ixrBcXMBxarN6EljSjlOCs4wJuRtcr2nL0ClMRnDJ52m8iHEcvFxUyW
         DGmdaGdyDC5c3bfKMLy9SQiE3NLE62YCOhq482LNTwC33dq6IX9TGa0ThD1To607dty/
         Qk1Zow73Z3AxdSOihuHxVPi0I0IKuCmkJTlsPVs99vmGRYLiHgVhzYXAWIKQWZdwBnYG
         p8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752733634; x=1753338434;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dMULLTVpVqv7dK7IgKD5UscRXMfGKKGocHzIjlBduJg=;
        b=l30TeTfOd78DeC251wjA11Z4Ql8o5hhbNOMWSGphphuoyJnFNPVurTw07NKjAqYyKB
         Wmz09FpDTxN/spvRvX1dWF4kcgenjjJ9G8DdGsH8TyGLZtBebpLuGQyYCrJsymAevNTU
         rFJH1mdF6JE9PTjv+w/I6i7UmumgdtrQrkeQ2Ue9JsCa944dpypFciHHJp/ZgtFuEHwO
         FsqfZN/rj8FEnMCr67iceIeQT2qYaEp3NLOFpjjMv6xth/FJ4ImsYplUfeocOKwrjBzH
         H+080x8Wtk4UfCPo8FgbywJ7qr8oRoGIOXgJ1zIDzUfZ93dERlDHC6wgsbm5mPj12af3
         bjmA==
X-Forwarded-Encrypted: i=1; AJvYcCUzRkYK9N7E3ge4oa3+zNYi5cmcrMalypitbHTbwvfkIRO0F9l4dHDPpFO2Y6oGg4tFfj34i8jkybXHvRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZz3bb21gdNqaVleHV80nFcSbLekzFBh8ezXz/r6/uCC7tM/p
	7awMa65EwLmna4c/aiDd48aDC8S8lj4PufCwS8raWtVHZgunxDXxS6/u8w1oo1MuRitNb+ZKUNW
	uYeCmA8h7qw==
X-Gm-Gg: ASbGncvc8D2ZqSIIZjD1j3MvapSRWnad0jV8N8b4GFauytrSRSwdGpC89ZQOU1haoqy
	WlpoIrDSXdCC6+miTvldYSnCn0sfCP7lTFauTLT/jZRAg/OaQttgsj0DBdi0sBmsKvrqt4AA3Ed
	g53HIUMPhVvZhm2hkVoohE41ei5YsEKVyyE5gnCF+DE6/k7KajngefEeJoGxOLwT5QV1zemrUmE
	ny9dcZJa3/2WSiTmSZu1+j8EQyXpOCUYNb2R9gms0yE/MkC/6Ob39eu+ZevKRqRnGTSWZiWDKcu
	565lhTqRsNP34t6Hx5HQRBwW2LnwNdw9F8V7xQNFgUm4eX2+G1gBahAsRnPYvROTpcG+mnSBHv/
	48iQTKf7ROuUfLVK9Nw/GUFBtfBz/HCyzcrIvuYJGa8VclYVR9xJ2z9Jy
X-Google-Smtp-Source: AGHT+IF9a43om4qwgcmFxHyk8twYfyDWlHEsMHaoiDb9jvi+87ZzfY3SJkjrZxOIH7xwJwnMChdjOg==
X-Received: by 2002:a17:907:7b9d:b0:ade:9b6d:779f with SMTP id a640c23a62f3a-ae9c9b13e4dmr648808166b.32.1752733634110;
        Wed, 16 Jul 2025 23:27:14 -0700 (PDT)
Received: from localhost (212095005146.public.telering.at. [212.95.5.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90a16sm1295669566b.24.2025.07.16.23.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 23:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Jul 2025 08:27:11 +0200
Message-Id: <DBE47UNGCDLE.3AZF5XENB5BEB@fairphone.com>
Subject: Re: [PATCH] dt-bindings: arm: qcom-soc: Document new Milos and
 Glymur SoCs
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250716162412.27471-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250716162412.27471-2-krzysztof.kozlowski@linaro.org>

On Wed Jul 16, 2025 at 6:24 PM CEST, Krzysztof Kozlowski wrote:
> Extend the schema enforcing correct SoC-block naming to cover Milos
> (compatibles already accepted by some maintainers for next release) and
> Glymur (posted on mailing lists [1]) SoCs.
>
> Link: https://lore.kernel.org/linux-devicetree/20250716152017.4070029-1-p=
ankaj.patil@oss.qualcomm.com/ [1]
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> I asked for documenting the Milos name at v2 of Milos patchset... it did
> not happen and patches are already being accepted.

Sorry about that, I seem to have missed that.

However I did not see any dt validation errors with my milos dts or
dt_binding_check on the bindings, where are these patterns relevant, in
case I should touch it again in the future?

Regards
Luca

>
> Cc: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom-soc.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Docume=
ntation/devicetree/bindings/arm/qcom-soc.yaml
> index a77d68dcad4e..27261039d56f 100644
> --- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> @@ -23,7 +23,9 @@ description: |
>  select:
>    properties:
>      compatible:
> -      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd[amx=
]|sm|x1[ep])[0-9]+.*$"
> +      oneOf:
> +        - pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd=
[amx]|sm|x1[ep])[0-9]+.*$"
> +        - pattern: "^qcom,.*(glymur|milos).*$"
>    required:
>      - compatible
> =20
> @@ -34,6 +36,7 @@ properties:
>        - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm=
|x1[ep])[0-9]+(pro)?-.*$"
>        - pattern: "^qcom,sar[0-9]+[a-z]?-.*$"
>        - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
> +      - pattern: "^qcom,(glymur|milos)-.*$"
> =20
>        # Legacy namings - variations of existing patterns/compatibles are=
 OK,
>        # but do not add completely new entries to these:


