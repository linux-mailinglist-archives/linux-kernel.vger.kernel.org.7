Return-Path: <linux-kernel+bounces-824592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482D3B89A31
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD8D3AEC35
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC07323A9AC;
	Fri, 19 Sep 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eyed/DFU"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF8321882F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287851; cv=none; b=H6y2cCgTNxHzr9/ZWms6uxn/gyj0D/hHzgLHwlnwWDdunZA0XtrnPGEvdIbEhrKrWNKM64PDWtOPEyLl6ZWpv7xbcrS0Sc3qzKzBYOw5UDcD9m12oDAKqSBWKU4GUCG+dV1IKp64wQoS6Ig2/T4AMj9z0SMjcw70049+NSbZ4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287851; c=relaxed/simple;
	bh=eSREDETOuCirK9j7pp0KaT4IL5H8FAZmt4obtpK9FwU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=samypQ1vtb9W2BpMabTBGHMZJcPCgVbu3cawblbT8/j3XjosKtzvQaOyNZKR0mRxTKTEaKq/gRUqfGJEbA46WeC0GCNfMyxo8uM3mtiRdBT+XEHCUhzMpzlvRe3O/a1Kq6dR8cbqlvM/7s6JHZVoaaRbRAFQr/flSGvU1Ao01Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eyed/DFU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45f2c5ef00fso16946235e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758287848; x=1758892648; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eSREDETOuCirK9j7pp0KaT4IL5H8FAZmt4obtpK9FwU=;
        b=Eyed/DFUcHC/eY9Dwk4WEIuNjwmF9UxRzgbac3/eRs7vXT7HafKOX9/WmJtUm81cNU
         16D8oo56DzfuODKP4SnAWxfuawbSO6wrbOP/S29XpuW7QlTl5CLAe2AcDhxsAcvWLtWp
         sO2wgGz60g91ftbQY/TyVOzIcsOwE/ANEEFKYDxJ+UtuCryb2KAqjWcsjMgUOZiVOlkM
         oZxAtnmMUnqtcRirGwMxeTIkBuZ0oCn8ET/gfBcTDzzQfCmKEcwjssSWaVjMy0pPEg53
         iAzCLx/TxSbsgn7IbZrKaCf35X0ILKQBPyonYzO694lTAFZHLrnCthURULfH8ECwFrli
         OEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287848; x=1758892648;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSREDETOuCirK9j7pp0KaT4IL5H8FAZmt4obtpK9FwU=;
        b=pE2d1+qGv0kU4l3Py584o4PMF5V5w7GNwsKHRZKTiNRMikISTj4+8M8lrTvQ3p41lf
         vMmGWXlHYxTwyCoUs2ftKB3WnM+PAwcN4IZLF1QihTp/oA63g8o1HmYqYftD8LD02Zgg
         TzqzgaaMZCvf8gejxPU+q50DFlCRMr8Z6lDJ29N5AIAKbTbJSGi3A376wJdmKan1zZRN
         /dBJCz51scbVxzBvmHQv5OsK5J5v8evnKr45eK7wiKBD3O3lEu6x2flZwt6gyb2FLyrN
         N4rox0uwrpsrWCtyq7kdLhQWJgLwG/EaaoCoT/DyIy92g9Kle/bTVfbWNM5kj+/XUsHj
         W//g==
X-Forwarded-Encrypted: i=1; AJvYcCVpxXk5Xd6IZkWhUzdg2KfEB/gR5X0FfUJexoaPabjWQf3MOXyRU/1Dc189glf+lj7tgySovCR517kY/FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXfqStWqpF4s0wWaYPWKfH1qWe8EAAcOQWity58r/HcbSHLqY
	hQ8UpIW05GVs6MMuikXhvUvgBKmaSr8M/yEg+bE82Kik67apltg1xrYiGtq35he9dwo=
X-Gm-Gg: ASbGnctL6O7HXDMopkA9OXoaTuWSpFf73wVVmAmBS/jVj7xwyTqofJ5zFCiFWzvO+hY
	R3Nr9wGtUhRNd6r3VTV2WWVQtuFiWknX9mopu/GCWZRhg5py+0loyb9twCON80/8Z+CvgmRo+Kx
	3PQntnNscTfD7uCYr+QQXd3cmuybxS5VTdoxyjjsySaQh1JGXkXyNlCWHaMQi8Eu0rPt/u1r4wy
	Eunts1u4ERUWv0at0AG7L0aVVPXAKBbDSF1TVYJMlIWSdMysS9aKOo+cFmZN4qHsvF8gDQIbNU5
	btEbTFQHmwPkOZNEtdRKciGWYvMlWGLIzmYUdUtHAdEKTdbHrOVi2yF9xTFtmh1+JEkWfgQ2ZTg
	uQ9SBVutJgsQeSMvFiU0HppyX7qUbemQAYXF/
X-Google-Smtp-Source: AGHT+IFOEEL5rr0JEeFyk2H6x0E84IJDnhVN8O14E2Hi/9ffavovVbWpQzybBfB+MObNjmkLFHYNTA==
X-Received: by 2002:a05:600c:6305:b0:45b:868e:7f7f with SMTP id 5b1f17b1804b1-467ee8c56d6mr37027415e9.17.1758287847647;
        Fri, 19 Sep 2025 06:17:27 -0700 (PDT)
Received: from [10.1.1.59] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f6695a9dsm88797825e9.24.2025.09.19.06.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 06:17:27 -0700 (PDT)
Message-ID: <dfde0a91359b87d4eff88815b4112ad17cca9935.camel@linaro.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: power: supply: add support for
 MAX77759 fuel gauge
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Thomas Antoine <t.antoine@uclouvain.be>, Conor Dooley
 <conor@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Peter Griffin
 <peter.griffin@linaro.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, 	devicetree@vger.kernel.org
Date: Fri, 19 Sep 2025 14:17:26 +0100
In-Reply-To: <65xrumpt7ug5mqd7mkcknwyqmljrn4sofrqymg46bwvcmjoarr@wmt5fhsj3viz>
References: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
	 <20250915-b4-gs101_max77759_fg-v6-2-31d08581500f@uclouvain.be>
	 <20250915-presoak-answering-2df6fca532ad@spud>
	 <c5f2e6e8-2ada-476a-8557-85273b9a93b7@uclouvain.be>
	 <a55d7e6e6d9515293ca735f25ffd5c925a6ec617.camel@linaro.org>
	 <65xrumpt7ug5mqd7mkcknwyqmljrn4sofrqymg46bwvcmjoarr@wmt5fhsj3viz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Fri, 2025-09-19 at 00:32 +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Thu, Sep 18, 2025 at 02:02:55PM +0100, Andr=C3=A9 Draszik wrote:
> >=20
> > Additionally, the FG block can also measure temperature and battery ID.=
 For
> > those, a combination of (top-level) PMIC and FG registers are needed
> > unfortunately. Which means that the FG should probably be an MFD child
> > device, even though the FG itself doesn't depend on the top-level. Othe=
rwise
> > it'd be hard to access the top-level PMIC register.
>=20
> My understanding is, that the FG has a dedicated I2C device address

Yes, that is correct. It also has its own dedicated interrupt output.

> and thus cannot be a simple MFD child of the PMIC.

The core can still create child devices if a child uses a different
i2c address, as already done by the max77759 core driver for the charger
(which e.g. doesn't have its own interrupt). Some MFD other core drivers
also use such an approach.


[...]

> Assuming I understood things correctly, I think I suggest to model
> things like this for the battery temperature/ID:

Nice, yes, that should work - didn't think of that...

Cheers,
Andre'

