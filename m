Return-Path: <linux-kernel+bounces-844313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D4EBC18A5
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED6C19A40ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4992E1737;
	Tue,  7 Oct 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SccgwECQ"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0BD2E11D2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844413; cv=none; b=PvhHLUp02jZ331slOdC44AARFecttukzIZE7oERCLbBjpEXAF/ygRvnoDtuysU2Ep+L5OW7JF3UNs2n3Rnlk0ze8DI8DlSxfRXBixcKfHKTTzTZ6HmwubZ/exVAbDGTjulZaV+/IQVsCNNPzYk3wnJ3CiGFPTUGo0qPO0CNSaNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844413; c=relaxed/simple;
	bh=B5zJo6+e9mfBQxyG03vxeQAF4XuA277T13ti7Xburds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkWUAYVsu6DniDOogIgdjvJzxgd2JmO52HHapUB8o0MxAfTsbAse31bfXX6EAH3etyyJ7zHph9PFBb3tRre9tDL+S6jITSSpx4Wdc9AZfoAunLHehXVUEtgq/VNdFvmrtbAGH1sWyL3yMq6X1OS7gMbCG8UWqO2F0LhCHxKB22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SccgwECQ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c0dd405c38so138861a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759844410; x=1760449210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCQTFpOCLXGsaDGm5R3fay+Aj7gDLjtHX2II8z9luO4=;
        b=SccgwECQKdlHJtKHZTALExpUyJA1W2HAOQBisHi/IGW9k5Wo7/DZQAIh5LfVEtU/l+
         8EBnUmjayBl98gNHztXYG+UkJ2hTx8AIqZiCE5n7OToOWbEPIq884L2CnaOmFB91nioB
         9xNG5JkPpuYfawY+KY4AHR3gjLhuysUIwjJudDMKcEqeSntjeYVX9DNjbGIC9WydnIoo
         GuWFW4hgSGf2vx/Tz84C4lWiQqqd2Rd9aYgj1zSTSricBtRC4SqRx3+4sICZZJuJAXg3
         kEt8+rTp+1UNb2H2/qJ0YQKDU1UlsEoDkkAUri1wuRqtpSzZQ1PmqEtn0R5I7VEiyrEY
         E4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844410; x=1760449210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCQTFpOCLXGsaDGm5R3fay+Aj7gDLjtHX2II8z9luO4=;
        b=vFjBRoqPBfRNMYGb8+BAkVEro19FoeqVxZ2E9K4311D8xNTOY9LO/OYqMe4K7Vdr5w
         DxqTVlskDgHzlKAtXEf4KvijjYoflEEJ1XvWIEuq3y+V8icKiLwo3namH1voLlzvFeyP
         m5kEviKu0jvqsxq+s1+b788qSO3qEnED9H9VWY6X7Rr6XWh0RkrReITe3JT69fl+WsSA
         yCrdy6rbe4ctjIZ1WbHm9oNv0opLuxjBbJZFW6GI+X5nL/NENKg1+3aRQLkg/JjJyekl
         c3Er6sQRa/0RyhDTLhUzaUxAyHbg2ZzVygLJ2PlaygmRNarpVfK1yKjnJhnzM4Ey+lGI
         iJiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/FmQcAd/TrNHnhf6yTeVeCRFl7KcjWcsR2X6XKsOr4zXqEU8ROKUOzwpcCW8DdGiJjLghcpKtOfD0w90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdUaltiGFDMLa4pgcj3buPr6a5RZAOX68oROn01tedzN95Bhid
	ZHp7P8fxAKZIbjVG6lGUAVFLYQqSs3n2xcnnxTjBRwyzZ+1Y7NCzUyOLAQIWjoQMCYurFDCcAgW
	mr7zeSCu3kwbJWTkc+V5y1TGiv6q8dz8=
X-Gm-Gg: ASbGnctkA1HFVNaciF/jpYOo3QMJu0Xif438nA8fs01/P0vKSUtOJoI57yvJT6s5feO
	UbIYH/f04n0wAioc5yb1M1xKnHS584FldO34qZrVNU7FXZEw1JYMe2nxyydh5QbY6rpOxHGD27X
	ffY0coJtLE67exq7IOYuh0Rc6erezSJg7fiLYEyLFZ0sryQzrWCWJ18mEP7Ds1wjjPjundWTPLE
	dhBjhK/VjwtqSBXX17SPfP16BXhxKo=
X-Google-Smtp-Source: AGHT+IFaX/eNzGSX/0xQ94MkT4x6GcjLTrj7/eYCQtsj7JxcgVbmL9x7FOv9ascQlxHmQ5isdD+BlSAOUJF4t34ed2Q=
X-Received: by 2002:a05:6830:67d9:b0:771:5ae2:fcde with SMTP id
 46e09a7af769-7bf772db651mr7720312a34.2.1759844410206; Tue, 07 Oct 2025
 06:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003091304.3686-1-briansune@gmail.com> <aOTrsYllMst3oR03@opensource.cirrus.com>
 <CAN7C2SB5Re35yGYsqr14hGXde3nTKLX2Aa3ZbuJ9xuT0m07uxg@mail.gmail.com>
 <aOUDbF/i4+9PXc1j@opensource.cirrus.com> <CAN7C2SBsFQJ2qNe0HLfpG+6cuONtpChBnq6fuFkd_CGkLt2c5g@mail.gmail.com>
 <aOUSZ2pnxRfxEPi4@opensource.cirrus.com>
In-Reply-To: <aOUSZ2pnxRfxEPi4@opensource.cirrus.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 7 Oct 2025 21:39:59 +0800
X-Gm-Features: AS18NWCJzGH3rZLWEXtfYgf2RrERANUmm3tsSEcxJkdLTt4vNPLp_FNxuVYAWqU
Message-ID: <CAN7C2SBDC2LrWpUTe3zZakHCrmUy1nQ-WiguLQKVK1CyOPb9zw@mail.gmail.com>
Subject: Re: [PATCH] sound/soc/codecs/wm8978: add missing BCLK divider setup
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Charles Keepax <ckeepax@opensource.cirrus.com> =E6=96=BC 2025=E5=B9=B410=E6=
=9C=887=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:15=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On Tue, Oct 07, 2025 at 08:48:40PM +0800, Sune Brian wrote:
> > Charles Keepax <ckeepax@opensource.cirrus.com> =E6=96=BC 2025=E5=B9=B41=
0=E6=9C=887=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:11=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > On Tue, Oct 07, 2025 at 07:22:10PM +0800, Sune Brian wrote:
> > > > Charles Keepax <ckeepax@opensource.cirrus.com> =E6=96=BC 2025=E5=B9=
=B410=E6=9C=887=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:30=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > > > > On Fri, Oct 03, 2025 at 05:13:04PM +0800, Brian Sune wrote:
> > > > > > The original WM8978 codec driver did not set the BCLK (bit cloc=
k)
> > > Its not missing its right there. That said your way is probably
> > > slightly more standard these days, but we should take care of the
> > > interaction between the two.
> >
> > What my missing meant is if run with DEBUG flag on that case had never
> > behave as expected.
> > MCLK and LRCLK both is correctly outputted. While the current
> > unpatched version will generate
> > wrong BCLK complete break the codec. As such I proposed the BCLK patch.
> > I had not investigate deep why it never calls but the "int div" is
> > loaded and computed by where is a bit puzzling.
> > And the loaded it simply with div on actual mclk/2/bit_per_channel is
> > also incorrect.
> > As mentioned in previous explanations, the clock register is a fix
> > table on dividing # that is a LUT with restricted # allowed.
>
> Yeah the existing code expects the machine driver to call
> snd_soc_dai_set_clkdiv. I am guessing you are using something
> like simple card that doesn't do this.
>
> To be clear the bulk of your patch is good, updating this in
> hw_params is probably more normal these days. But we need to
> make sure the two paths don't interfere with each other. Think
> of a system that is already calling snd_soc_dai_set_clkdiv() to
> set BCLKDIV, after your patch BCLKDIV will be set twice
> potentially to two different values and would generate no error
> messages.

Before the below action started. I need more background, if possible.
If my understand is correct on your ideas. Do you mean the default driver c=
alls
the bclkdiv on other places? But how could that bclkdiv # be correct
from first place?
As I had mentioned the div # ifself like this codec is a LUT rather
than the actual divided #?
For example /32 from LUT is a 3b101?
For example what if MCLK is set higher than /64 could even out of the
LUT from first place.
The external div # passed in, how to ensure it is codec LUT compatible
from first place?

>
> I think you have two options:
>
> 1) Remove WM8978_BCLKDIV from wm8978_set_dai_clkdiv. There are no
>    upstream users that I can see, so this should be fine. This
>    would mean an out of tree user of snd_soc_dai_set_clkdiv would
>    now get an error so they know they need to fix something.
> 2) Only run your dynamic BCLK code if wm8978_set_dai_clkdiv
>    hasn't been called. This would mean any out of tree users of
>    snd_soc_dai_set_clkdiv would have no problems everything would
>    keep working as before, but at the cost of a little complexity
>    in the code.
>
> I am happy with either approach so which ever you prefer is fine
> with me.
>
> Thanks,
> Charles

