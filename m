Return-Path: <linux-kernel+bounces-895923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F8C4F44F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD4824EF93D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722EE3A1CF5;
	Tue, 11 Nov 2025 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfWsnQOs"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8EE2F7AA4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882628; cv=none; b=qPCBpLMren34yRdAiHrK5f6ynYgptAOmnpRge+/i5btj7e93EEoLadapGHEpDNaai31n+HP7l2zKXV+Lo0Sn2IfyEH2jeOVK8BSvqfJal0Jd+I4GmRzhxL2OXY+nK6KXSA7LkRN3s/vml361TpxXhoGQTBn3Q+6FnMOIOei76R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882628; c=relaxed/simple;
	bh=fFHQ30lbbXkJGJiOTu8jKIDEOvJD9OY0v8O1+2G20rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdwELV2B8GbhCdT61kdOukBHWk7LJWcuW+qA2Pfdw1RFBm2N2OCaS2cdvOgXI+d0F6srJ6PJIj1XSxm5sN3MqlkWg+ktimqRB6upYwpE3Mg6up/zz6SLnSrfn07prTERmcnesy7PH6LpxD4+ODBMEDm3lZIIXBqd0VSVEAenbl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QfWsnQOs; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-786943affbaso34315287b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882625; x=1763487425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hVkOL9QZX3SGwC8VnESzgQr/GWl5l8+eTHtDxUY9Odg=;
        b=QfWsnQOswTz60sfpTGv4lJxmKdVFVt6/Zh+ekUqni/20p1bRbyecTO6ZYWjeIMnrB5
         6Vz8boN8M0QFpduBAhtEw+OjLMA7jJytRWpCcRxT/Asi7IeJVrTIVRUt3LuhCLVIFNZy
         wvPMo6FJ+jvrN+cu9N/wA76qgrjm9Grx4PX5IO9T3Hu1yNkLnOpNKn8LlAJ5OYekA2L/
         2ME9ubKyU/cgw1Ba+pbh48MsWbbH8Daoz0v80IfToxKpOR11N78jMoh2Bo7AQ39e7Mhw
         ncjzLjmmFVu4u/sDIBEf0Xdt6Sjnei2R3qV20sVzLV92Kg4c7kbVkJO3AeK7ZuKm1umq
         puzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882625; x=1763487425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVkOL9QZX3SGwC8VnESzgQr/GWl5l8+eTHtDxUY9Odg=;
        b=tQ8C0iuEh+mgwDRZtuMyIYcncbBlnAOYzJoLGSucN93vNzjD8cslyE+jFitubjBj2+
         PHTBlG2CB1tNqu8QwjWvjv2xv3xNN8eIciYbsemUc7FZ6kkbsXVKYLUx2wCRRxsBcK3S
         O9kr9/8WQzly1Vnpxyw2hwGRm3/RZsngOYlxILvjy/2i/2nD/SGGmiIuw2Zw+mQysZsW
         1LkAqXEswbK8HPdaZcEJYctvzxRE2GzWxnPU4rmODzB/FAd4Sq6zxWi7vPNk8IqvMXYc
         YUBWd5aq/xTNwsLeXF4kR1TysqM2qVKqxjOIXp6hd9lad6LdRkirBKiQvwtIXotfWbzZ
         tPhQ==
X-Gm-Message-State: AOJu0YxfXqWNLS1PDIoTHa/wP8DXv8i0fbjJhFg0wuWY5mjYAGpd426X
	nOOAUGRlhEP50tCr7sx0EJ/Oj4b2mf60gpztpDQno45QuPxBZW6tE8Qt0llE83okGEEsIMzKoRs
	ZLnk7XYFIHhNu7BbijFnD+JNk0LBYjOn14IojFetZ1w==
X-Gm-Gg: ASbGncsPat/2eXtojpGeAiOiviOkSEG5UFvnR/8eWonwHterkz+SXDgtVvOrfI43hho
	0oS1xwnOZB4CfzChVnKCX9V0QGY9ZII37F6YctQb9sFBrw3gLd8YK+dvl/UO0W2JkQWglgcCqay
	Kb04XRjV818sLUhr97QlKhDNjm/ar9xYsQCLtWQ9+iGzvEjUGi8c0d7haEUlkYdrX0HN9wikw5J
	Huwyt4gSd9yhAHmUloN02E3TEerKsTBasVQoi9vAEVQHZt9whEijAdzuSWnaH9AF2vm29ghxfEW
	7EUTf6Y=
X-Google-Smtp-Source: AGHT+IE9bOE8QuaDxevERnXGMwxyKuXPLVIGn9fuMsvYZZWVI5o61gMBE7ecmjC3IlvCAc62kGl0QOYlCbs99m4/5oE=
X-Received: by 2002:a05:690c:2021:b0:774:cc25:7f51 with SMTP id
 00721157ae682-787d5400960mr102720837b3.36.1762882625058; Tue, 11 Nov 2025
 09:37:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105145824.239054-1-marco.crivellari@suse.com>
In-Reply-To: <20251105145824.239054-1-marco.crivellari@suse.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:36:26 +0100
X-Gm-Features: AWmQ_bnwqubEIg9CpgOv8nmNo9i2Cpu9HPEm5MczRr9wHyBCajECUb_uyu5SNtk
Message-ID: <CAPDyKFpVS9Z86D_QLhjvOYFAbXaa4_Z=ZQnV+x1ZTuXG4x8oXw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: replace use of system_wq with system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Chaotian Jing <chaotian.jing@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 15:58, Marco Crivellari <marco.crivellari@suse.com> wrote:
>
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
>
> This lack of consistency cannot be addressed without refactoring the API.
>
> This patch continues the effort to refactor worqueue APIs, which has begun
> with the change introducing new workqueues and a new alloc_workqueue flag:
>
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> Replace system_wq with system_percpu_wq, keeping the same old behavior.
> The old wq (system_wq) will be kept for a few release cycles.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 79074291e9d2..daed659f63f6 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1214,7 +1214,7 @@ static void msdc_start_data(struct msdc_host *host, struct mmc_command *cmd,
>         host->data = data;
>         read = data->flags & MMC_DATA_READ;
>
> -       mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
> +       mod_delayed_work(system_percpu_wq, &host->req_timeout, DAT_TIMEOUT);
>         msdc_dma_setup(host, &host->dma, data);
>         sdr_set_bits(host->base + MSDC_INTEN, data_ints_mask);
>         sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_START, 1);
> @@ -1444,7 +1444,7 @@ static void msdc_start_command(struct msdc_host *host,
>         WARN_ON(host->cmd);
>         host->cmd = cmd;
>
> -       mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
> +       mod_delayed_work(system_percpu_wq, &host->req_timeout, DAT_TIMEOUT);
>         if (!msdc_cmd_is_ready(host, mrq, cmd))
>                 return;
>
> --
> 2.51.1
>

