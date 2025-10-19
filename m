Return-Path: <linux-kernel+bounces-859588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1752ABEE08B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF6FC4E1D5D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114F92309AA;
	Sun, 19 Oct 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By4si/TO"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68971096F
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760861793; cv=none; b=r5zfcFxSu9kveFKLkebUS/SFH4x66pZS20JKX705qw6pzRW2GrPJgf8n4JdmOjM+s3EmTULIyCFqUpk6QgacDz4VxHqL6rdo09Ta2ROCCsYlpJCRi535qHbvqgx8tvagdtJFpiqRZ7AeYx/dWDZ7gheSMwuLtzRslxyfQQybfak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760861793; c=relaxed/simple;
	bh=5/cDBEEuk00gOvPqadE/j7HUZTsf9NAxcz37M63a8Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1zu7rvSPPRMFizmCml5opzfsLAmvkKM8Xq1J508kMMljrERpSnjBqkETVYQTX+ONot24I76TV5PY9tEd9r1zhmqcFEd7/bIDXAJ4EY1mhiOGGo3C6XothDOFHVgJpbkcVMiKSJc2cANgk5HBSfR3zd2bJ9TUxJ7nnD31ccfQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By4si/TO; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c1006fdcfso6256901a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760861790; x=1761466590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Imi+yHV6Vz24/NN6G7OYYEtuPVrB4hedJqq0w5ebXQU=;
        b=By4si/TO+iencgxiuaLRGZbc/5t7eYsW34/K8L9fDEaYHFgeA2yvg842ix/gX2dNjt
         /8MmHUUr5dY81Oz0R8LVrnWCD536uXfNP4lPaTgTpXwdm92omEB7z9jXr7PGMrBA88wJ
         IpEAjjaaH/m6KvHyMwlydbzjxjXGtyjLQcDtmLEvw2jiJLE/Uy2Zqfkm74O8e/16mTyK
         3gY9bCsnuExY/WvhTF4CXqMzLUrjse0754oHefC/B9MuOwdgBOpLBfGqc4ooNa/z95J2
         Wj0Ydjo+CyBnkvA0dWNFXFR4Ffp07gwpdvXmW5hzdot5ZXwtXF7ucwWZUSSwKWBNjZd2
         F4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760861790; x=1761466590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Imi+yHV6Vz24/NN6G7OYYEtuPVrB4hedJqq0w5ebXQU=;
        b=DmWqJXiUkXz+dJKaO1Nd/gKWrTsnJ8+8b6oEXdMcfc3ibEVbk64MJG40z3qnTu6WqT
         Ikg22UIW10TwdXahcG2fTNT7Yvz/p5r2ttMznYdsyeWePjDm52+BT42PDX6lRIfm0OQL
         Bxes/7I0lFnGcgis7mrLrUKZrwNyz80hAefocyks8J1vw4dYARomHndoX+OLRADKiiVI
         yjVGDzrraCEwJpmX8UCH+3vGwAy/snwO5u3dCPmnxgrrQJBxm5+kfcvVt+NcDJWs1abO
         C+PBp9+DCr7qQhtBAqPimsjEt3cHUYeDxHF/pxkNc8a0lkYmo/brTl5md52XvWDgqbwt
         lWrA==
X-Forwarded-Encrypted: i=1; AJvYcCV2qFERS/oYHtTq48F8G6nP1a6gEXVBNa+mj3MQOB8Y3N8vicRT0ORMIwO/JZxaEaXoSlpI/Z6fJ1oLS5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZrEaIIxQ4UEpB/+CZTr+pRXI9lYjHA/VvyY0kx1sk3sNASOcd
	IN2J7FacN7barjxrajkvnsdRiwIbl8cIwE+9CTlw70VvHOh1kGiu9jLldLASn4Tsyc0Y/TJKa/1
	QXYbqe0Pv70fIrCKhaT+Efqy5PPLqABE=
X-Gm-Gg: ASbGncse7Q+dsc/Nbla8XO0HFcZzrrG7dUSJL+orM1jOPz9ZGPWuPT7z619p6PC2z2j
	4qSLjg9xTi9LWWotm5CQ99mGfodSF5VQq/BNlBrrYlMfrB+0S2j+quEa6cxzB1wbHUMR4ughkRL
	EfD7O9+rWWLAd/lWxbkKqgBbGsWacG65pFOBglAi+MtgUYdUKRjSpwkSnDBfh8u9XF+TbtK4W7w
	ZLjlbVjjwevY0suXimsNgjK8ExMhIE71CYN1WOnLuVH5Um+ubbzvua1yS3KMtfGhv0v7g==
X-Google-Smtp-Source: AGHT+IGRgUoroGo1ESf9sp7vTzmdzXX/6zUe9FmWd/0Lf4Ov7s5z+s3QAStl8x73vjGt2cqHLBUa+zR9WFmPuOp0Z1E=
X-Received: by 2002:a17:907:7203:b0:b1d:285d:185d with SMTP id
 a640c23a62f3a-b646ff7d658mr1081118366b.0.1760861790039; Sun, 19 Oct 2025
 01:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b153f5f-fbec-4434-8d07-155b0f1161b3@wanadoo.fr> <03a8fd58-cce5-4b84-adef-6cec235c582b@web.de>
In-Reply-To: <03a8fd58-cce5-4b84-adef-6cec235c582b@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 19 Oct 2025 13:46:15 +0530
X-Gm-Features: AS18NWAOIHt0L_7boDcPxnV8XZX-ioqAZ3uVOHGaQzZmmxUZhFoA2mAW9yFF8_k
Message-ID: <CANAwSgRv6J864HF4Qqab_6qq96=8oKn0aHT5WjypUykgTJFmzw@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: Propagate dev_err_probe return value
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Christophe Jaillet <christophe.jaillet@wanadoo.fr>, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

On Sat, 18 Oct 2025 at 21:36, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > >     slot->num_supplies = ret;
> > >     ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
> > >     if (ret < 0) {
> > > -           dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
> > > +           ret = dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
> > >             regulator_bulk_free(slot->num_supplies, slot->supplies);
> > >             return ret;
> >
> > Doing:
> >               regulator_bulk_free(slot->num_supplies, slot->supplies);
> >               return dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
> >
> > Would be more consistent.
>
> How does this view fit to the commit ab81f2f79c683c94bac622aafafbe8232e547159
> ("PCI/pwrctrl: Fix double cleanup on devm_add_action_or_reset() failure")
> from 2025-08-13?
>
Thank you for your guidance. My previous understanding was incorrect.

> Regards,
> Markus
>
Thanks
-Anand

