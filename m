Return-Path: <linux-kernel+bounces-879401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF7CC2306F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A3D1A6399F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC62EC0B9;
	Fri, 31 Oct 2025 02:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KzwF/Wjw"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3481271443
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878003; cv=none; b=E5F2r2/iS59sGeKcAc05SEPf0/NrwyKL6lZzzjWgYdJE0z8xD48PSpc9WByIdSnGTaMHmOGcfMYugf/QBw5dhI2YUDfmhSx8e0PpGSz44CqxtZQKnVsJ3wsTNy/216pUvoYBC/qNPShCdMXH+5qdcTUeol5U6KwTzNsUdTRHOF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878003; c=relaxed/simple;
	bh=7YEkuFyM7GV9199Q9Cdwe7iIO8q9KIPqtZTf+2Ow1j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESjHYaMSEc7t835v9V/ZoE41mu4KnVeXT5T4rR9G+OnAU3OhANeurFsHT8zwXa5HH2VbiYYMwPNKJ1/UkEfxQg6UkcnRDtbFwkdYZihnmcfVVkTG59QpCN2Ou2AQG18fVOXCdgrt9AM3o7m0p3Xi42y6fJBOJu9yIe0gh4Wfz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KzwF/Wjw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3401314d845so2477402a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761877998; x=1762482798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbPYQDjulAXBG5F+f0kqq2MBzbj3aqWGdDjqqCk9C80=;
        b=KzwF/WjwdZQs3n3EhFjvTt/XdSPx/O6z0bAi9IUkrK6dBMB2yU7S9PhJDL34dS9KLx
         fAZZzdOB4Mkgdl/lD3i9YyGCR+RaKE7Kxa2Z08WaN4KLh8MXl03pKiYVEujPlV0G75oa
         youq0+fQ7NwU/+IJp50xuA0gsWKeyOVcmCB13cLuvMPGJA0Lb7tbPb8LzJuVKr+DCK2F
         4ttvU0zfJRtvCBD5GpKJL4mEzadzptlE4Hwozn9Ohu6WsjpGWsxU8aooBZUkwUkujUYb
         eN/fY5Jlw9R06xczpPxe7W2hG6Ioa24q11uXWJ6t9HT2XAIjYifY8ovnYU1g6rSuBtu7
         m/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761877998; x=1762482798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbPYQDjulAXBG5F+f0kqq2MBzbj3aqWGdDjqqCk9C80=;
        b=owLXTxprlphlHGJlVgM4S0jMLkDwjZsTSXtvS9VGRes2y/Amp2KhmCMa4wnrv/uCWp
         VYH98adFzHeC+rjgM/7/MFqAG8HFTeErD+TcIXGJWziS6zSDPk+qDCSKOEI9h4kT29rL
         qpHmhV04QKF7MokRygfj2g0boHzs7Kesl012uTiSn+NigQ7fGrMIjv5uI2AfIIinzQAK
         olnQqcO1wQAdnxW74y2DC0PcZyblA3hKhkyaQy0Uik6b7cqYK6SQ1NXi++ZmhJjVMVMh
         lFzLtJ0NBR7VLGdl/C/gaZ2GteruimCoN+idrIPcGevE5faa5QdZhFr8iPO1LEUAEPmg
         Udhg==
X-Forwarded-Encrypted: i=1; AJvYcCUnRk0twm+6tSFC/1DRxjsLmja9E8XPoev2UV5dHNGoab3r3kkX7a9Xu1XeIQ81//fXDYz4Lv3Y/krVZJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqTdyfPkn3xB09xn+m2S5j2nfHFTRq/yEA4Cvf6W6jIm5wIQc
	fTnXHfAV0ih8JtYC6qjeUYpr5hXwhCwu30BJTfBxhL/g0C/vY/5wspB9oJoAv+n3JEYwYaXLLZX
	1axIH3h2wYZN74/FfcfzEV/iMUCBdGlLHo2PSdu7aFk9XjU7kFgFB4YlnVtA=
X-Gm-Gg: ASbGncv5rXlGS1Vr2DInGjD1N9Uhmcp2oUzKBMskESeQa08FUQ7OUC87ig2sKlNqGZB
	qM/Tz/f9PyvPzQXBsZkZNx8kG8ZmSFPDDyd2ysd9opq5nm4rpwJSaeRI0chNOejK8HW6g43tbOm
	eAmo9L5Fa1X6AIpRVUSWbKfeHMzlTRZYG2WdyCDdQij9PIsNLoKZ1jVOz4YYdmkGw1zseAY7+AR
	NGK31n9pRtpnyJCyUx8rKJ2Cmyabo2XBY6vetp0jhaI3KB2FU8hZ2sYv5MQHcuNrdQsIxMNYmuM
	lOJUuzU=
X-Google-Smtp-Source: AGHT+IGjdANt+fuPlj1u6k03al+PwTeWwPQvya+7WRgxiU0mxbxxM8F4uL4nbN+EmMMgXPpkgs95B3SzwTo2s5qdsy8=
X-Received: by 2002:a17:90b:2b83:b0:32e:70f5:6988 with SMTP id
 98e67ed59e1d1-3408309b5d0mr2256670a91.32.1761877998236; Thu, 30 Oct 2025
 19:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-5-eperezma@redhat.com>
In-Reply-To: <20251030100025.95113-5-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 31 Oct 2025 10:33:07 +0800
X-Gm-Features: AWmQ_bktjbZKQJQHAYSDluD2qGdC80xHb84razKBk8_a9ZP6wgNu7U3Zy6qD5y0
Message-ID: <CACycT3ssC87PUdUrGyZqbm76-kNZ99Bcn9D3W1rJ3jfNi9df2w@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] vduse: refactor vdpa_dev_add for goto err handling
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Next patches introduce more error paths in this function.  Refactor it
> so they can be accomodated through gotos.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

