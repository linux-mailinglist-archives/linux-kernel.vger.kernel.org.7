Return-Path: <linux-kernel+bounces-765819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DDEB23EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C983B6A47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C1A287517;
	Wed, 13 Aug 2025 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3/G5Eqo"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D23728727D;
	Wed, 13 Aug 2025 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755054059; cv=none; b=M1xyqMs37RbAopE+IlO9+0mbDIw/gSAlgxKTmbBDmTkFjcy7dbF0WyAANnQd+Jw/E8deGkmN5diw6jR78inafuujvfTMwdDKuNIpsuglKLBNzSovSrZwzJQtt+i7zTYDwIGb28NUZjTLT3kXuuKkUPubFBluFLkHPOrVO8Cn1RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755054059; c=relaxed/simple;
	bh=czfJcOW2I5IbBO9jq2k90gZaH0QbcoDMtl0D5+nFG8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkxbdiLbX66IeqZWyxm3brBCzZbG75Ndw5FpzqVJ5Qt2el/AKHW115B2Y66hAliAXeyKx5K0TszlqL4kWemVPs6XQreB77K0pt9oRrJD8yXzBsGF4s5I55tLUN28AfqXKcdEWCGYxiLINykWPkNCKq3SXqiW/YUd6gh3hi5Jg4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3/G5Eqo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-618690a80e8so793588a12.1;
        Tue, 12 Aug 2025 20:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755054055; x=1755658855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5y/seLrTvBMt+gpVQiMdJf/k2I85/lLFOQXuyrwZ2g=;
        b=O3/G5EqojNhGvFmuAvnZ1XwoiVYfkKu4puNNOhR7cZP6HXqn/Aki2mf45TJREmJy3Q
         gAo6mYzkL0Ui85WFpGuQE/OXk85UBshH16ZptlKCK0mbataEG2xot613A981AHuvso5+
         SsfvAuT0IwCgqKbYfwWjGb+XFM3dnNw9g0KuIr1MmKSX38j54APvvknY22u6gDW4UhIX
         RrioUDb1AUgy6Hl8lMZr7ijksLouiWL5WnuQWrhTHT6xTdGxJigv4mI6zGHnI2v/6y/h
         1G0SteNtVjXA0b+0z7trEhXQDu5/f65bhKu7iTj4eGd6S/RUzC1dzt1bPb7K2w66k9R9
         eKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755054055; x=1755658855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5y/seLrTvBMt+gpVQiMdJf/k2I85/lLFOQXuyrwZ2g=;
        b=N7P0qoF0CcERk7dToFCxI/XqpKVd7ucgBEJH5AK/YjmipdT/NS/2WCesfdC13npu64
         ZlaowJPn7uNA8gUDhZ1jHtJsabVVKvggLzri277apOuSlVTFHIUzrdxqt3tkyrsbBpCo
         JWz8PFVci/AEoa6Tjh53FjQLWaEQqRVEvSXEJmcyFjRxXL25GtxnvgxdzwZdPp/uBymW
         JKlMxwCTr2tVnMlap0hc7TrqmWay9/SkCZCxQAQ2zsdoXuofRdiBgANI4wdmwBKOBL4/
         Sp9k4u+VvG/qCEHMAx9Kokf6OFUzL2GwZG/hDdfx3TNSeDyAGhHEsGID9PyD2QPYdglU
         9PqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU20KNL9EB0pFmTc8dZ0I8jjHka5x49XYENNKU9TcGODSVas4hCGTpzyG98xhiK1sCMzvkkOVPSCG94@vger.kernel.org, AJvYcCVsa+1/66DfdUazu2PdbgBtWCb5Dw4GWxAX4ENMg7Qfp2ZulyTmePutlB50Qca5/LNpICl67ds6Gfd9iqM=@vger.kernel.org, AJvYcCWlvyQkcBOA3rUpzAG7Xy4darlqs7PwjI0v8YAqmHNbn6zpfVtKkAMVN0XksO8pOIWeqqCrSNuEu1MX@vger.kernel.org, AJvYcCWuCDqF3hiizgMJIDeGNalf34EYFQbd4jcY6dJVKWUWy7G81VczX7owQ9fiIzarwtEii24aW6ObS4Tgh1Ib@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wmiZ7/uk8s/dqiC3SpsELZsJ0HzN7ZYCx1jOp0u884E9dcR/
	Ychqlu5fdqFHpYX7h8DyLhGwkUdYWbmbj8tqY4anAybmYoApk7dTxhQiZbAQeI44RMPCnrZzMg2
	i0akPOLh6/s+hoa79nuKm4DV0dDTEqxHJC4gu13HB
X-Gm-Gg: ASbGncsGve2cby8+ReoTFRBRRay5ytTNAC7JmRgC8TG9YCu7tA9bUk3QFIYeZnkuGPq
	B2doZiREcmFkhmqqElIYvZuIL86lO5pn3Bcm8pWLL3lO5377WDWSwZxbIYSEtbP+j/EKFCfdrug
	Ff+H4owdjL/QA/RII+74kcsOrraJRW0wAl5DwiEv0m4HMvATBDMvLrwQezrL17kAXZ59m2n+aWh
	dBcwAg=
X-Google-Smtp-Source: AGHT+IFriJKM9I7frIVACO5KjhXef5YD11+byhMuRGqO/vaDtpfAwrOZ27kuJaTbzeMk7qDekUxUSnb9pVifUQt2TVA=
X-Received: by 2002:a05:6402:36d:b0:618:dc9:ee84 with SMTP id
 4fb4d7f45d1cf-6186e2b8fd5mr594586a12.7.1755054055453; Tue, 12 Aug 2025
 20:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-hwmon-tps23861-add-class-restrictions-v2-0-ebd122ec5e3b@gmail.com>
 <20250811-hwmon-tps23861-add-class-restrictions-v2-2-ebd122ec5e3b@gmail.com> <eab6d2d2-9337-40fe-81c7-95dc1956ce6f@kernel.org>
In-Reply-To: <eab6d2d2-9337-40fe-81c7-95dc1956ce6f@kernel.org>
From: Gregory Fuchedgi <gfuchedgi@gmail.com>
Date: Tue, 12 Aug 2025 20:00:19 -0700
X-Gm-Features: Ac12FXyaBW8DdTOgjlG7L1lv205rtGaFgH74i54E7KCBSIfk1L3jdwEFSS7-LRc
Message-ID: <CAAcybusHjAR67N0rumb6M_uG1ct3aa=zv2XkpUjhSSxv0NdzFA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: update TI TPS23861 bindings
 with per-port schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Robert Marko <robert.marko@sartura.hr>, Luka Perkov <luka.perkov@sartura.hr>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 12:20=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
> > +  shutdown-gpios:
> powerdown-gpios, see gpio-consumer-common.yaml
It is called shutdown in the datasheet, but seems like neither powerdown no=
r
shutdown truly reflects its purpose. This pin doesn't power down the contro=
ller
itself. It shuts down the ports while keeping the controller available for
configuration over i2c. Should I call it ti,ports-shutdown-gpios or maybe
ti,shutdown-gpios? Any other suggestions?

> > +patternProperties:
> > +  "^port@[0-3]$":
> This goes to ports property.
Do you mean I should add another DT node that groups all ports? such as:
compatible =3D "ti,tps23861"; ports { port@0 {...} port@1 {...} }

If that's the case would it make sense to use "^.*$" pattern to allow any n=
ame
and drop the port label? Is patternProperties even needed in this case?

> > +        tps23861@28 {
> Node names should be generic. See also an explanation and list of
Ack. Should I also fix the existing example in this patch?

> > +            label =3D "my_poe_controller";
> Use useful names or just drop it.
I thought this is good as an example? A useful name would be board specific=
.

