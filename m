Return-Path: <linux-kernel+bounces-859641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C411ABEE2E7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 12:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF9C3B35E3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AE82E4274;
	Sun, 19 Oct 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOCDcxVb"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3629D288
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760869186; cv=none; b=aEoH88jEf0eTlKJh4gApSDu4kJco5aiMMsDtAD8DI+pzmBl41sq0xGWZsuMzPo7C+q3aXT5JuTqyjpSge9N68+0BlNMT9iKWo2VEZ9Zxu/PNvXuigekeX3hjGzqEmF0FXLC4yAXvMUdHDKvsGxr8diqqv0Hsdx2QJIq3qHMkPJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760869186; c=relaxed/simple;
	bh=AvSMkWBk2P+bf9T9tvFUkUXa08IIJOiWTUuacIDeoek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1cmUaZ3Zjyh3uXUbsIarVxE93vtzgYLO74EpundH6Qf9fd+9089f22JRdlo3Dx/yGEH+ViGzcEqE3iMiqWfNW+SP2//O5ivxuJ4cldNv96z4ei81hQJAOKIvNmO3Y87G62ebWOvPTveP+i9PwcFJS8gwT4wh2ETeB4XDAhE2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOCDcxVb; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so5814815a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 03:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760869183; x=1761473983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AvSMkWBk2P+bf9T9tvFUkUXa08IIJOiWTUuacIDeoek=;
        b=hOCDcxVbWlR+j2joArLp3enyz2A3go+Zq6vCnX7gJs1YVRl4rOlRSyUY17Um5JUy3n
         XNGtPNq2Ys8IaSluyuNZt8eIqse2TSFHq6deSlTUiKDyRbq+IhELanpPCLJEt5kA9nBG
         sm/dIJTlLRaWfn7Y+dUoYdWJdTg62VRgXUQikrrDcI+OslQVn+FPpsHasnzL/pkSQYEH
         grbnsQWsHmuH/IBrjErGF13Zpuqzc/8c6ucNxdsksyCHV6Bljwd45gpYJ8mu6BRvX3vQ
         B5O8SdxC78oMTjdGaqaSWzzudVqcyGUna8eWUagrzENye7SglKgLWlsyzHg7FW/JawFv
         fOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760869183; x=1761473983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvSMkWBk2P+bf9T9tvFUkUXa08IIJOiWTUuacIDeoek=;
        b=aFZzmgSPoop3POIB22VbyCWLHhKbken3UylcI6iUbYnWeEVTpZo0jXWByPFR8k1trn
         uoUGiwBJYgqoqWoQZ56Pw3Hae9uciPd5ArFw0360/2+nUvdaBsqeFZe/eh1WbCCWTijR
         CY9y8PGU/pU9FwR1uP88Gx+JKcFoW8x6YURkaAc7cvCaQ4mD1gFKW8w2miAZ7nx4aCmi
         i/8y47ypfLSQwWjzIp2ZwqggkgouXnrh/ezq1ewtgqbUn5XlCCbeEC6rlJRzELhGUeG+
         5EGLHzxhsLCx5VF1ddgg14S9t0ZSynjBeY8OYmnvibJIO7cjVPKzn1VtWcrlmTsV+QAy
         jnzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW+soUnXW8F0SV/lHCEudsZBewc/BzTPxx6iClg5AaXsQnKnnGgWcuzl33qnGGGSjrWGhmBdZzLK+tGuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTBNmZmVQWhmVY5eHn0vG0livB7beokWglTyTLnMdtX8SmSQNB
	2TY79P3G9PFR49VSMDaYx4r9mEClZmvbK/YHSeZvRiz6EXIQGnNjrejf1T9MYvGGEGZReTynJNA
	U2G62A1u7nza4gxGc01qLmduCMp2FW8I=
X-Gm-Gg: ASbGncswRAOTuZdQt93C4YrP9gmPjqeEGdxzwBtdNH8zgOZi+7BU1b8o3XktFKosSBE
	OcViJqajyM8jkIi8FrMV1zM/plD70R2WI+qFfPPx6GLZVce0xhoWtVwE37AHmGEad4GjC4EJEfO
	heRLjdqIm4zHSWuk+80xKvkEsgDYEF6vihiO18BGWu791zSiIDYVIxyj+78QK4q96T8yOWmgmjH
	+nlO7ETCf5ykPUEkvwX2MzKiYV9F0PipcwVAmVKGMXEZiGG9/FnoBIjvJZUaUj+GTo47w==
X-Google-Smtp-Source: AGHT+IHJ1tnb98CMoVnwt5Oq2sMdy3alKsHrj5KesBOi1LOMklAyV4xT7dnJUZXb8MKel/MUWFEzehg9HP3NPFtujCE=
X-Received: by 2002:a05:6402:1e95:b0:63b:f3a9:f5f1 with SMTP id
 4fb4d7f45d1cf-63c1f633eebmr9023808a12.14.1760869182751; Sun, 19 Oct 2025
 03:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b153f5f-fbec-4434-8d07-155b0f1161b3@wanadoo.fr>
 <03a8fd58-cce5-4b84-adef-6cec235c582b@web.de> <CANAwSgRv6J864HF4Qqab_6qq96=8oKn0aHT5WjypUykgTJFmzw@mail.gmail.com>
 <e88cb990-bf11-40f7-9c71-b14614fe53bf@web.de>
In-Reply-To: <e88cb990-bf11-40f7-9c71-b14614fe53bf@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 19 Oct 2025 15:49:28 +0530
X-Gm-Features: AS18NWC9ThuvYuttzm6oV6rgSMF7z_2qt5iRg3jbf-_Yb9XXNlpi814XZb8xxY0
Message-ID: <CANAwSgQmpJGo1SYDOmDQ39Fx5UH3_v857qiJpVCcxqUK=_V0Gg@mail.gmail.com>
Subject: Re: PCI/pwrctrl: Propagate dev_err_probe return value
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Christophe Jaillet <christophe.jaillet@wanadoo.fr>, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

On Sun, 19 Oct 2025 at 14:26, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> >> How does this view fit to the commit ab81f2f79c683c94bac622aafafbe8232e547159
> >> ("PCI/pwrctrl: Fix double cleanup on devm_add_action_or_reset() failure")
> >> from 2025-08-13?
> >>
> > Thank you for your guidance. My previous understanding was incorrect.
>
> Will an adjusted software understanding influence further collateral evolutions?
>
I will try to be more correct and improve myself.
Sorry for the inconvenience,

> Regards,
> Markus

Thanks
-Anand

