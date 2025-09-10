Return-Path: <linux-kernel+bounces-809168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE944B5097E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A25A1B2772B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002771C695;
	Wed, 10 Sep 2025 00:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHdVbXT9"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544513D51E;
	Wed, 10 Sep 2025 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462595; cv=none; b=CXiyNr9thaiirO05cZOlXeaHgwqbHX79Rcad8tzSNyNA9f3Zn5gi70OyexSsdPRRXk+4Fsv0IW5pRR2YZopJtpThT9h42NMKWu7AWubdKj0ZxM0t+Ka35JCQIp+iHIP7FRwlsn58K/fXzW+SCkHYxhNG6LUsY8BSj94buvTlrqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462595; c=relaxed/simple;
	bh=NjT32UAKvl13aq5XV+kTsjdAy65nzMBFlOCuvIsB2Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RU6Fi7KK9hniDTuRcskChcQoNgUeHwUg8eHofvUcb1/0ybECNnOD0pF4eWL06qtsAFh3+T8gltamXML0KV1FnuIjQYYflIYuz+gQ1+27WRdRRFpiBY210AIaypwsfxe8dQb93TWrslQ3OWM/qk+DLg73jdhyHUr6Pj8yARO+ApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHdVbXT9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f72452a8eso7400737e87.3;
        Tue, 09 Sep 2025 17:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757462592; x=1758067392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+htEZdSD2rDWbR+m2mXqSv7espiCRXxlYqWM68DDKk=;
        b=AHdVbXT9TRbZltaLMWnsqPqAQAcefCddyB4K297VuTJiuObL40aiLXqIC8SykJ+L10
         W5Dm/WeQGITFQFv+xKMxluwkfqpY0q+hXrRI86TJsSZWIkRr7/SWOMJ0ffKCwX08BgOh
         woO45WWGcorBYhwiA1nrYCCnxCpj1GRziixYBkdf9BzXVMraRy1r4vPJa3nTvH7k5vfg
         4WlUgl9iHwHS0I01YFx4ecvBo8BYnOPRqwGFcxVmWFD8fP/mXGksQWwE6MOnr/+iUGh7
         0H/PPKF9ggGCH79lg9UpxoIZCLXZQElTA0FCYr9CELhdyVnFlPmO9PoXkFgM/8uiKmWw
         dmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757462592; x=1758067392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+htEZdSD2rDWbR+m2mXqSv7espiCRXxlYqWM68DDKk=;
        b=Lk0Mj4pDXyGxqyHtmBJwbFM3q27jLYBPFQWmgbeD/XktxeKnsWHUh7PHPwCQczCpbs
         uhIqR4v2kOn5xi39+q6JmkVihMweSJK7HUoEFm9kBOX1YGYLQN1dZnPm/Y3pKMAs6iAW
         l/2NTD5UAYPdbbUEGmfPuKrZvZ1ytWh59PqWU1NSp0gN+bTI1zv8JXC+SQlVoLaNzco7
         7MvjGEWHblZW7PjzMskZSqlfT3OieBz6jJB4hsu9jQkh4FtimA0+TOytD2TLjVCZHkwY
         OBQzh6oY39oY6TKBjn7IBTMo9FsqwFucYf7BGHQD4endSInFO+e39fKxpcAm+EF3ISF6
         fafg==
X-Forwarded-Encrypted: i=1; AJvYcCXYIA/DX4kl7Rq/kSmCA21elS5tAqAjRZ+1SMj7NK8Z+w0Mmuss9ELjOMf4+pxigIXdMZ5yGxNhp2QUpXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBp+OM1yBB2lmyJfgi6KfuRBd9ExIGudhz+D5drh3bGrw46YSd
	He71b9L0IkRkvp2ghLsoJU0GvfkbgNNUBe8atsh2Q1RCBN0yBZGNboRD4EzyeQ==
X-Gm-Gg: ASbGncuopd+1x4a2zsxKPL3/frZDU4rjgGEv/TTrOe0fH6m503spXaZj71Fr0Hd6Ltf
	iA+q+aPUWMLC/efUWKwUDMkeE8zvid1SV3sMbWekhe9CUKY3WKGGFJiDplB/xDaImAPTlIp9YdA
	6hH7+wzRMvSOvxwjNjRztBG+V7vtcCE0KbalfvZuevtWGxBL8eES1+ARauOOGCIozRzX8CAGFcd
	/JD7F0nVMovLUVO9CO1MxPAUH4fnpuuDuSRqpZIMDhIG09EC4ut2U+wUOkJ7UoNP/+cD5gyJd6S
	FkOikfuRBWrTZ7cHegdwEH5x1TA9Ip9v3lFEAE8y43y7ZwlIIEtNCKwwpRgR2cuDivicFLPwBwA
	MbMeL1JyQ8ouo86izjj+/I+0shJhxXi6cTiGQ7y2YkxC3TQ==
X-Google-Smtp-Source: AGHT+IGMCYubKMN79pEKoDqh9ItPBNdikHQxIEu6FgZAnSZy8Yq/rKuVxZ4ilwzZqzYzTcNwKTXvZw==
X-Received: by 2002:a05:6512:1149:b0:560:8b86:75b3 with SMTP id 2adb3069b0e04-562613147a7mr5303113e87.3.1757462591473;
        Tue, 09 Sep 2025 17:03:11 -0700 (PDT)
Received: from foxbook (bfg216.neoplus.adsl.tpnet.pl. [83.28.44.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-568188224d7sm848901e87.120.2025.09.09.17.03.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Sep 2025 17:03:11 -0700 (PDT)
Date: Wed, 10 Sep 2025 02:03:06 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] usb: xhci: Queue URB_ZERO_PACKET as one TD
Message-ID: <20250910020306.1d77d7e5.michal.pecio@gmail.com>
In-Reply-To: <e29fa12b-55e4-4ab1-b623-11feb447bdf7@linux.intel.com>
References: <20250908130128.7ed81912.michal.pecio@gmail.com>
	<6ca18b05-80d4-4988-bb08-3cad003e10f4@linux.intel.com>
	<20250909193859.73127f85.michal.pecio@gmail.com>
	<e29fa12b-55e4-4ab1-b623-11feb447bdf7@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 01:57:39 +0300, Mathias Nyman wrote:
> On 9.9.2025 20.38, Michal Pecio wrote:
> > On Tue, 9 Sep 2025 16:04:33 +0300, Mathias Nyman wrote:  
> >> Adding the zero-length TRB to the original TD when we need to send a
> >> zero-length packet would simplify things, and I would otherwise fully
> >> support this, but the xHCI spec is pretty clear that it requires a
> >> dedicated TD for zero-length transactions.  
> > 
> > You are right of course, an empty TRB in a TD would simply send no
> > data, or maybe it's a TRB Error, I'm not sure.
> > 
> > But this is not what this patch is about - the trick is to use an
> > *unchained* TRB, which is a separate TD from HW's perspective, and
> > to count it as part of the same TD from the driver's perspective.  
> 
> Ok, I see.
> The whole TD without completion flag does worry me a bit.
>
> We need to make sure stop/stald mid TD cases work, and  urb length is
> set correctly.

It looks odd, but I can't find anything wrong.

4.10.4 discusses what happens when IOC is clear on the last TRB of
a TD so it looks like this is allowed.

If the first TD halts or stops before completion then it doesn't
matter that we cleared its IOC. Everything works as before, except
that Set TR Deq will skip both TDs and the URB will be given back.

If the first TD completes, the xHC silently moves to the second TD.

No matter what happens to the second TD, URB length is calculated:

       if (ep_trb == td->end_trb)	/* end_trb is second TD */
                td->urb->actual_length = requested - remaining;

where 'requested' is full URB and 'remaining' is TRB transfer residue
which should be zero because buffer length is zero. Looks OK.

And curiously, this behavior too is no different from what exists now.
I see nothing stopping the second TD from overwriting whatever was set
when the first TD generated its event (success or otherwise).

Regards,
Michal

