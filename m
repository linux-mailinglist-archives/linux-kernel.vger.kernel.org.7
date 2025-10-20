Return-Path: <linux-kernel+bounces-861484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8975BF2D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F07D4EB354
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2912BDC15;
	Mon, 20 Oct 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq9mmExE"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBE211CBA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983256; cv=none; b=ECy2w4JMfvzHYmMafKrZvA0Aeoq/jxkLFABWozXmS3CspvLANpfcdriGlWhOk8p0dpuXi7gc6r158fdXnqcIKOLrQ3t8637g+BEMMSgLrwn6Y1qk17FqchaeicL3OCWyVfxb508lGKuEKChvmAsWWOu3M0vbC+nSloM5cr5wjWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983256; c=relaxed/simple;
	bh=+ouTqeK8KjHhGyZubwi3mpbqQWmjMmEjydzA19keOOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hm4BIylzYHITtgkgkFgRYf5Q4IDkOR6qnCO2OWIiYjc5MWSidqxY+7wUGe3DqVSTTc702LUfZyEq04niEkS6UKCO4RpfNB+Q5pIJbQHV1nzcYMVN0MDIBnYgNy7Q8cytBdJKIIYZwF83B6osAySRU3aEt3GmnuBEETfVKh/1oPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq9mmExE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4202636b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760983253; x=1761588053; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ouTqeK8KjHhGyZubwi3mpbqQWmjMmEjydzA19keOOA=;
        b=Oq9mmExEZL4ZdA7i7UXfvwZ6w+EwAAFEGa3w34rikHgKESzAOKzYEpVfQletv96uwG
         E9RsoCtDqfrzO5mdrR7wqeonFrtzPKzzt0Q3EazJSPfRk/u/Ow4KwzGv0kNhGB57Z1H/
         mW3lt5s6MYYRWenEs34RCTv34itJorycykLcuyWrLYQfTeRqpH8mCsStsUSxvkmG631w
         Sc+re2UbLOWG/uQUzq+MOdqoTns4vXJIBeE1/KhE17bsnmBaisa19OPqfk1geZupuv0J
         kRNncSB7pcj7jvjNtrnalM4WPjP5k+WjNIGdWVsaSfgOpGq0fe/+03nHMOjQ4yJfpC/I
         /O/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983253; x=1761588053;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ouTqeK8KjHhGyZubwi3mpbqQWmjMmEjydzA19keOOA=;
        b=I6t6aP7adFrHyIjz86jNHdjiJkruYFTYb9eCzeXf4L+RS9sVFKZF+uSu7TJlpg8c8W
         B9/P8wqkQGwTBQaFMtBzQ2rqliJeD133rhLcNvh70AN2+LRbUaq2Pw54cL9roQQuAmq/
         KeziZmKqhhGfpXVIGouNgNas5mXFuxv9rFbFtkzmTGkd7GQ2kgcdHSfQfUCyehnwDxwo
         vS0leZMPysuBm7o+jpOZlGkbdFHokEuNwLwwDArg3xKoJRA76QXP0zsUPZHh3N71wolr
         gy558JEo36XTteQweZ3U75SNSZ1S8LkgXjxrpcuTyY47vVShscl1HbjbdLGwSFGm5LEo
         xk0g==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/Viniwb/3hR5+CBnUdLt51Uj9C8jFYNiQ6pMQ+2xq9n+Tkk5zG+5b28K8jrUf8Az28v+Drzxt/euGmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRRL2YT4AM/yUdccsWKODqy5y0Q1busxerDAgLvC68Ou/NY/82
	rZC0K8zhquRuYiJuPcw0T9fLCKdln3UH2A1K+4Gnam8MRIWuFFEVD5xR
X-Gm-Gg: ASbGnctnKn43H5jXEez2bnBDvnFvFaeORXn0r60ErgOQ+1HV4em9aL3QJvqXlnJC9p5
	bou6ck4aEe0HWyCLpQPIxg5IjlTvPl1OIVdj04ET6mikIE/H0T+E4/JIYLxe0TtBEfu0cfPEm9w
	drl0gY/kVfnuJ2VKWxou+ixMj854uwBnHwkWzrPmasuace34OU0GN5GvJn/g/jhv6IXP2g6PjAP
	yJXNlC1jAJqass29fGbKVm4ghtEE8FE5YFaQDxad9DR3l9DivyskzaNADsJy0gF3FhjKVSKSwmh
	P1Ii2BDtBybbWKa2OZTovQkuNeyhB/saan8tX/aiwknvKvg4lfuOQP5KBLVt6p2JoYua1Um4gr3
	ITjw7tHacJLEyisHIBwZoF5ybFgUkFcaMDsg8dkfTg7MMfCdFApUSldYcME0XO8/6Lb+lAYcvU1
	jTLTqWereNs3j1UMl0qQtiqOB5x3PgHTFuFKYHb1lkPepFWvVyrwsVNSKDdyfDYNivgpYJIIo=
X-Google-Smtp-Source: AGHT+IFyEI5povAc8sFYaguQEVG54DJVwm3UpywxXfyVqK9JFR92iJ+L7mTz5exo3Mj/xjg9HqAs9Q==
X-Received: by 2002:a05:6a00:1393:b0:784:27cb:a2c6 with SMTP id d2e1a72fcca58-7a210d899c8mr20387861b3a.2.1760983252776;
        Mon, 20 Oct 2025 11:00:52 -0700 (PDT)
Received: from TY4PR01MB17309.jpnprd01.prod.outlook.com ([2603:1046:c09:20a6::5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230122380sm8855641b3a.77.2025.10.20.11.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 11:00:52 -0700 (PDT)
From: jonathan brophy <professorjonny98@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Jonathan Brophy <Professor_jonny@hotmail.com>, Pavel Machek
	<pavel@kernel.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Radoslav Tsvetkov <rtsvetkov@gradotech.eu>, lee Jones
	<lee@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: leds: Add virtualcolor group dt
 bindings documentation.
Thread-Topic: [PATCH v3 2/4] dt-bindings: leds: Add virtualcolor group dt
 bindings documentation.
Thread-Index: AQHcQOxnIJ58J1ZGPEecG/r284d6fbTK6VoAgABojfM=
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Mon, 20 Oct 2025 18:00:47 +0000
Message-ID:
	<TY4PR01MB17309CB1B7797B52FF031A27EF0F5A@TY4PR01MB17309.jpnprd01.prod.outlook.com>
References: <20251019092331.49531-1-professorjonny98@gmail.com>
 <20251019092331.49531-3-professorjonny98@gmail.com>
 <176096011281.22748.15975544575193365055.robh@kernel.org>
In-Reply-To: <176096011281.22748.15975544575193365055.robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=0A=
=0A=
=0A=
On Sun, 21 October 2025 12:35 AM, JRob Herring (Arm) wrote:=0A=
>=0A=
>=0A=
>On Sun, 19 Oct 2025 22:23:25 +1300, Jonathan Brophy wrote:>=0A=
>=0A=
> From: Jonathan Brophy <professor_jonny@hotmail.com>=0A=
>=0A=
>=0A=
>=0A=
>> Add device tree binding documentation for the virtual LED group driver=
=0A=
>>=0A=
>> that implements virtual LED groups by aggregating multiple monochromatic=
=0A=
>>=0A=
>> LEDs=0A=
>>=0A=
>>=0A=
>=0A=
>> Bindings for the virtual driver are not describing hardware LEDs they=0A=
>=0A=
>> describe virtual devices made from groups of hardware LEDs created from =
an array=0A=
>=0A=
>> of LED phandles.=0A=
>=0A=
>=0A=
>=0A=
>> Normally the device tree is used to describe hardware not virtual hardwa=
re=0A=
>=0A=
>> but it is particularly useful in situations where you require an LED to =
be a=0A=
>=0A=
>> specific color by mixing primary colors, such as multi element multi col=
or LEDs=0A=
>=0A=
>> to be operated from a device tree binding.=0A=
>=0A=
>=0A=
>> It also becomes useful with multiple LEDs operating the same indicator s=
uch as=0A=
>=0A=
>> ring of light indicators where the LEDs are driven From different GPIO o=
utputs=0A=
>=0A=
>> unifying the control that can give basic indication during system startu=
p,=0A=
>=0A=
>> shutdown upgrade etc...=0A=
>=0A=
>>=0A=
>=0A=
>> co-developed-by: Radoslav Tsvetkov <rtsvetkov@gradotech.eu>=0A=
>=0A=
>> Signed-off-by: Radoslav Tsvetkov <rtsvetkov@gradotech.eu>=0A=
>=0A=
>> Signed-off-by: Jonathan Brophy <professor_jonny@hotmail.com>=0A=
>=0A=
>> ---=0A=
>=0A=
>>=A0 .../leds/leds-group-virtualcolor.yaml=A0=A0=A0=A0=A0=A0=A0=A0 | 110 +=
+++++++++++++++++=0A=
>=0A=
>>=A0 1 file changed, 110 insertions(+)=0A=
>=0A=
>>=A0 create mode 100644 Documentation/devicetree/bindings/leds/leds-group-=
virtualcolor.yaml=0A=
>=0A=
>=0A=
>My bot found errors running 'make dt_binding_check' on your patch:=0A=
>=0A=
>=0A=
>=0A=
>yamllint warnings/errors:=0A=
>=0A=
>=0A=
>=0A=
>dtschema/dtc warnings/errors:=0A=
>=0A=
>/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/le=
ds/leds-group-virtualcolor.example.dtb: pwm-led->controller (pwm-leds): led=
-1: 'max-brightness' is a required property=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0 from schema $id: http://devicetree.org/schemas/leds/led=
s-pwm.yaml#=0A=
>=0A=
>/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/le=
ds/leds-group-virtualcolor.example.dtb: pwm-led->controller (pwm-leds): led=
-2: 'max-brightness' is a required property=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0 from schema $id: http://devicetree.org/schemas/leds/led=
s-pwm.yaml#=0A=
>=0A=
>/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/le=
ds/leds-group-virtualcolor.example.dtb: pwm-led->controller (pwm-leds): led=
-3: 'max-brightness' is a required property=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0 from schema $id: http://devicetree.org/schemas/leds/led=
s-pwm.yaml#=0A=
>=0A=
>/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/le=
ds/leds-group-virtualcolor.example.dtb: pwm-led->controller (pwm-leds): led=
-4: 'max-brightness' is a required property=0A=
>=0A=
>=A0=A0=A0=A0=A0 from schema $id: http://devicetree.org/schemas/leds/leds-p=
wm.yaml#=0A=
>=0A=
=0A=
sorry this was me checking my yaml's without validating the whole structure=
 as those are covered by their own Yaml's=0A=
In futurre I will validate the whole structure.=

