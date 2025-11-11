Return-Path: <linux-kernel+bounces-894790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D586BC4C1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E933BC40F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32551DE8AD;
	Tue, 11 Nov 2025 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deyP5hUm"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE8264A76
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845593; cv=none; b=d4UAk49Irm8+2zNDGnuC9/PP1gLo0UYwVcE5Cy51FjqwaAIucVdW4OJzBhT70fzDWvocfk/dmdxbHuIJZwpMyIBeH5dBHGzFfKfFjjeDgKRWWJiQWHxiVhuTCAj6zwb9V9587unVgsHgYVnXOA6lJnX99MajQHQf5rYa1zI2988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845593; c=relaxed/simple;
	bh=tmsSeEiwy7O2Flj+b3Ome3Ent2XkRKkKA5yFHv/r9jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzpYb9WyEPeEVUypDXDZ5tP3QYBWetjTrp+jofXJOabSlqE3+ELguuH+8lnMXA+M+fro6qbAxMhoQ5IzWSC2/ZNlD4Sji6KTiW91hCt1aLnoGWR0F87F1WozGn9eqFcY1k/cvGy/XpSeHQySJZ1agcIDKH4Q62wFjr5miG6/+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deyP5hUm; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b713c7096f9so561105266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762845590; x=1763450390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmsSeEiwy7O2Flj+b3Ome3Ent2XkRKkKA5yFHv/r9jw=;
        b=deyP5hUmZpr4RPloQ2KJbXdAXAjYt4lnKjsN62BKZNV0o6CINd3pWGAqYsJX2NA1jz
         1hRDayyVfTpPVxrUkUIjWENR97UKPRAhwwL5ppQreKaBXfv7cGG50hHeh+RQhCETznwk
         ET7UOIBgbmuhFYfEBUcMUs1Q/0sS1X/7XWq3VT5NNJw+/0W0xgAq/Ok4Ful3XBpNf4YR
         UZue0SXxvqkFoA4QZ87i2d8oPm+ufOQWZFrA90JaMvzVolTUygYlCdaobdIXKTDZkEcp
         xPnJdeCPq3np0Bf8v5YQEsNeOArjD+WZ/bIQpuFlQ0UFrWG6kYVD7EP8Nby4R4CH+s+e
         bhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762845590; x=1763450390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tmsSeEiwy7O2Flj+b3Ome3Ent2XkRKkKA5yFHv/r9jw=;
        b=CJMYT/p7pUNv48byuo5Fg06CYrSptsA3+/JrI2TqEpkNBkYzcoSSHDMi5mSOd+sOOq
         IhPbUN92GnN6NkaDr0yw0u+frLOWQjt54m44/R30klUuqGLw7nSlD0CNIYMI1cAz/CIF
         obn+oB5Gly4d3F9bHilRdvgsBujSkApURGfslRGmUBVp15DLAs3Vg99I0h6KATRU6ZKQ
         MlQZy5jjoL7tYNnvTv+EASC3rTCKbLhZKlu1v1o625GSfHIH2OwsparAU0qyVoxjRhbF
         /LEpC8PsV/uXCuPpVgdp/0FE8CZ2yOkrUsZ6PCXA06UmW+WrYa8n6cmy7jq+vmcD9FQB
         XFzA==
X-Forwarded-Encrypted: i=1; AJvYcCXnb8YtmaMIP23OVaJZPWS8NrNNfHJU883zoGxExKmJPbewAY4YJJbJ4bnvVP8xxIeseGlA6i/5WxBNvPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRydBKi5nd7YlmLmsat/BEW7d/9AuY52GEHeX9hUHIHSncs/eT
	6IeNXa0QXUA7DaKW/bTiIhqUcBQJQapq2Z5zThXMqesH0yUIYvaVb3dJwPkkjco9/v6ZN0jU0cp
	nisT4+4hwMzkx1Vom8BxN0f2jCtmHFGY=
X-Gm-Gg: ASbGncveJ5kOqTH4Fk0yJvEw7jWY1hqlYAqfcUmiqh+tHP4aWzL3dKz3NTYCKNDhobi
	hHVc0oDC84bb5BU4RgLSIcPFl/TW13StWxeNPR+XoNbwIWXTJPaZSKgg7KGOoVAGvUireCSy1BY
	HZRx2tQK/wlptzogNof9fkGdjNUBgk1GQA6gRpI8yX0/6oIpc+Pdxj/qNra/XuIAJhTXqoMzj5A
	S5VyA0XYsNP1lFA7V5nGi8ilMMd0ev6snhy2ikrlAiTFlWCwC85iBHeFh4TSD02iekVvtId
X-Google-Smtp-Source: AGHT+IEILfbpkde/uS7fyrqgf/ox44as1jmga0EcJSzlE0mw8B229GPU854X9ywyq4BIeWOjfBvkzZBAwJTDsl/4QO0=
X-Received: by 2002:a17:906:794b:b0:b72:5734:9fd3 with SMTP id
 a640c23a62f3a-b72e05626b1mr1255885766b.32.1762845589581; Mon, 10 Nov 2025
 23:19:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2Y7hwttMyUn0qsEcSBbrQ1h+aSzNpHMhgAxEbqJZn4vf5hBw@mail.gmail.com>
 <aRKll6BXZdW2I_Wq@casper.infradead.org>
In-Reply-To: <aRKll6BXZdW2I_Wq@casper.infradead.org>
From: ying chen <yc1082463@gmail.com>
Date: Tue, 11 Nov 2025 15:19:37 +0800
X-Gm-Features: AWmQ_blPfOg1c3a-jvdBes0ocXd_5-Vkj3sUlAGVbick8skM2v8TvUeUgmDbWRg
Message-ID: <CAN2Y7hzT8aADtejR2TUji_8ct2LUb+Cpgd-2G-pAUj0figB68A@mail.gmail.com>
Subject: Re: [PATCH] workqueue: add workqueue.mayday_initial_timeout
To: Matthew Wilcox <willy@infradead.org>
Cc: corbet@lwn.net, tj@kernel.org, jiangshanlai@gmail.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, laoar.shao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 10:55=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Tue, Nov 11, 2025 at 10:52:44AM +0800, ying chen wrote:
> > If creating a new worker takes longer than MAYDAY_INITIAL_TIMEOUT,
> > the rescuer thread will be woken up to process works scheduled on
> > @pool, resulting in sequential execution of all works. This may lead
> > to a situation where one work blocks others. However, the initial
> > rescue timeout defaults to 10 milliseconds, which can easily be
> > triggered in heavy-load environments.
>
> Then we should tune it automatically, not blame the admin for not tuning
> this parameter.
Currently, dynamic tuning of the mayday timer's initial timeout is not
supported.

