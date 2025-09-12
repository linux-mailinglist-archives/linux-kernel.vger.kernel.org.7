Return-Path: <linux-kernel+bounces-813357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166EBB54415
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0993A4A21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196802D24AA;
	Fri, 12 Sep 2025 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDufXfEx"
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975F2C0285
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662797; cv=none; b=JsXD3lExob9gCMRPJgAjICfd5LBlX1YkDoh8Qiuy0lVMnUWF4kUE4aqubF2hN1gx+WkFBUOwHb/K2WZrXrAJ/XvHEn6Cs4EC0syz3JMMSD7AWhsCGkMFliTnLoXceZDvB2GMHEDng4U7+Sojoev8nDU8wNuZlrgGEjggKkP9tvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662797; c=relaxed/simple;
	bh=gCGztrCRHBfCZpk85ZIcqeg1cxUwdKLVQ7c3JnDMCxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTZwXxQQiX2AQcf4Oc9wz65cWOOxmsGK4pIO1BNaF+ZUPsNfGo5QngqJb9F8XqsTmD0mACvOe8eVI7XYY4Ab3PocETLKvSbB0PntPO+KzOjlhom2Wdgf9HhrHFuXEjXWIYj7e9oLYdPVxQKygoWimVkn6L203fEWTJkapWXxTsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDufXfEx; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-570d0c280e4so562133e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757662794; x=1758267594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNLJiGTXtC8rqP8KwFGe1YAq+Z/FT5hcO7fvNlaM8HM=;
        b=hDufXfExdcJANcKiupzKEvmxOipvicxA7GeECuKkDIILKuoO6igkrKj5wjVd/2LfNr
         UGF+DB3G1ih0iBPQwH82ND0mg/Z75/QLgUodfFyBPEoPgqIOlFZyjHRnH1ezmRBuwM6j
         0945fX+WAf3vxn1Yzc3ye80ZQczYN6PWUuRGExXh/qiNr5kvflHN2v0QIjT9PmPppj5V
         JCL6OBEVou+/zlDZT0F2Edt14z8G5LJEHtQKGBbujEk3y0EEBaYQKaMVKrnQVGijQxiM
         IvcRrnsHblFfc6xLWgDPYqZa+PhFX1ZM2tfAQ3kvPxt4ZfoJdPaOE1V0NlZF1Ltao4O4
         Hyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757662794; x=1758267594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNLJiGTXtC8rqP8KwFGe1YAq+Z/FT5hcO7fvNlaM8HM=;
        b=sCdMXG1e97WPULhNrFJ3C0slyPI7iBKWl5g/ryNJe5OC/bpUiRHCjJYjrtANIvf2lm
         pkpaFkl1MXpsRa2uqbyHMXpHhq8kkx3bL73w90QgjufELvL0HFKQKRInHXhKxAmA9jnb
         cr/aj/xHeUN3B8gUThlOXFzdebC2grIGUFgaYZVkWDySNIfA0gOmSofRNSTUL+3rWSwB
         bnxg3L2iGVM2f1h4IuneQv999xLujyC7XHYLhPaRC7YtT5TDgnsYBqcGj2MRgPjEHjlt
         eaPniEMP9B0PRdO9wLNzD6NAsZh9xar6jI1aP4oiHp44kL2H0m/3r5IwAqyRESiZ0GIs
         vgjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLxS1CNMN/E0c7ew2KIUrgf4NNoxY/F1eosy/jEXrB7CHIsWF/ZdpGf1xaT17ssCiTomQTdrJ3hnQm4DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDUE2/JDIBol7PgfWxiH2JF+8vtihG6u3v+VFLYzOU+KsJmKcO
	XpjONY4lKOTQlQE+svWh5uBTbRKnZeNkrVjGjEcgs0V7lpb8oPySecoykxGAPGP3Oj+Su+OYvXN
	VZhSrU33GOMQcLeQiB6OT6ABnZ4ZFxr4UCV/vSdPt4w==
X-Gm-Gg: ASbGnctCtUA0u2AsmbWi056DLuIM4VGYHuppOXUMhWk/qCsz7Ojs1pJYio+Y3TbkQsu
	y4FzPBdYILv+jfcvinzfgknJyuoIE54K+j4b8McE/frLE+1ppFbLEK5aoRFjJD36umPkKKV7asG
	ZdKROVfmzfoL85+YV97DfXrmk4mZGLfghIKk9WwWqnqigK0qe8jLiOReuWfz+pFKaNGGXJZqAUr
	d5hEkkhCSO4K8KyMJg=
X-Google-Smtp-Source: AGHT+IEYF7mySNO9hM82MQlZ6I33EgJNmxHvAMnc7Dblmc1OiwZP/ubfkPJoEwZ1LSkzB64r3jzsPXBEPcc65jxW3uk=
X-Received: by 2002:a05:6512:405b:b0:55f:4b12:755b with SMTP id
 2adb3069b0e04-5704bec6297mr559664e87.20.1757662793857; Fri, 12 Sep 2025
 00:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910081655.355971-1-hupu.gm@gmail.com> <CADHxFxSBKuKUWDvki9QDqc5jf1Y+k2EpvOnDsg8O09pZ10n2NA@mail.gmail.com>
 <aMM6ejbed7s7_2t1@google.com>
In-Reply-To: <aMM6ejbed7s7_2t1@google.com>
From: hupu <hupu.gm@gmail.com>
Date: Fri, 12 Sep 2025 15:39:42 +0800
X-Gm-Features: Ac12FXz4cfB2XoOr8yh2UAq7Tl2w4YJgqudMX4cZItwB_BF23QHoBp9geBmk2BA
Message-ID: <CADHxFxTZTDVmP4EGRWei2vKnsavaFBsCLKZdoxSSyjWXpEZP9A@mail.gmail.com>
Subject: Re: [RFC] perf subcmd: avoid crash in exclude_cmds when excludes is empty
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 5:09=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
> Thanks for the detailed report and the fix.  Looks good to me we don't
> need to look up the cmdnames when there's nothing to exclude.
>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>

Hi Namhyung,

Thanks for your review.

Thanks,
hupu

