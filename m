Return-Path: <linux-kernel+bounces-879404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3A1C23081
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21D584EC9E0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4302EF665;
	Fri, 31 Oct 2025 02:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ersLdo1g"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386AC2E1C56
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878078; cv=none; b=olWgPSwtqErSqsxisQxTGi1cpMFt1fod4mu95WZAJeukjSo+mciW+wgljw+LSz5zVxWIi74wiW97r5SxcV486f3mp5UU4+4KiG/jDtTZY8ko99rGsIgCGFyTUGRLV1bvhOaoIbkcM0XhgGGeQgu6fzn+NXEjzYSsmeX3ocl4H1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878078; c=relaxed/simple;
	bh=ysdehcNuICx+mdrlH/8Kj4Jt/TmZ2EcxA6a55pJM4K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rd0tA9/skQDNx+dAfChA6JMnHJGXWCbBoLz/tiL/UcMJn8LlAZ7kiRJqUM00M6FpruIPei8kbf8gM0cgO2PJ3O+qU1D7tEcb9wez7Blw4eNbIqUeWR5296S3kkyjFFZyYfwlV/X+FIf4mfd2VxQtf9xysfZCbAxHaCkU3HOzPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ersLdo1g; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso1831295b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761878067; x=1762482867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysdehcNuICx+mdrlH/8Kj4Jt/TmZ2EcxA6a55pJM4K0=;
        b=ersLdo1glpsu1jXIRxTY31pGk9xL6KKHdfqrEB+E90sLu36C5XVZleOz4zxEE/MtZW
         Zk+H6TwDj6WNSN/+36zjIgu/cKhd3Bii1UlWT37V5BE6XYx3+9cWxRxP22AHCASl4O2g
         /pb7KLUpqlQpxjeR0oUPYyScD9nQZzbpRLrdETef2xj5UFOt5Yrg2JuJvAy+UkyUsr+K
         N2bFn8fto9sK2FYnMSO43d8cWYbyEPzVB8EMoFG+eqC5cnIIVbYKs48a9u79Jq1HPu0S
         yw2b4JqsfkYbTp+A+8gLLAtIwzUBy4sJPNYapcM7VFmStKM/qvy8Eon/ckbbgZ2/cpd5
         V30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761878067; x=1762482867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysdehcNuICx+mdrlH/8Kj4Jt/TmZ2EcxA6a55pJM4K0=;
        b=dAUWebUaOLcjcQSTeknPy6HB5dk7TDQTIXbk0y/FdPs+ykR87wnjRvmwoKdzFOEnEU
         NFxIjJGnq4EINqU8fmn6VQFiTgtQjnJ+/bzy2ew08I878W0fQd1IjLrJ3RgAW/zbTqvk
         Ygkl5uS9meJsg4ImSj2xVUll3eGyleE+1/uq17pnrx9JoUpxtLS+NMErEtHNYbWSPyyC
         TMoLsZbpuYfRS2dRWFAeCbdeHggaVtNaodb0Xzld4ACzmjChiKT9HRyS8RzUQUFvDOit
         SwZeZpOIxG1OMhNJF+szmXxXjlJaxT2jfjJ4PFUmU7k080ceA3IzY5U9rwMmNGPBqHCc
         SBxA==
X-Forwarded-Encrypted: i=1; AJvYcCUtEmTYCgucsnt+YbPCyxCJnSJPNkG0+V52RqxFkRKOFkkpoou+hz3gw5MRupod3glgpPFh7nx/U/qr10E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvhuqafE9kaRyLOTFOF00Y9wMefH0xopfq+TzK7XrADTWaYFGS
	ZHJFTayCtmCxN4JAQBqH7/MyHKIzOmSOk7pVuzsy6OMiJQsyqvfPQWRBQbEREkcqzk6cmbArI+l
	IFFfG3K1NE0gWDFFPdYCiQULvDKwiPCwgzdFQhhXT
X-Gm-Gg: ASbGncu42iFq8AEwvlbRecKDO5Y0QVYObrQ03ctDtwgU+E7WDAfX/REdMsvLk+3mOYW
	C6C8RZWVBu3PGYNp7nz/Ir+nTYpQgbkH6MTtzqdhQsqkAaQFKORMgdUuxT1ZJzoJeyShrzJ9ba4
	4zDrmBYYIczF1S9Qp6Uyg5QrQuIILTvncMP5cFjZ1vmimdeQ572KUxBPmwPBac2mAwgJM6NmxAv
	fquUX3eG/t8QJlz/ih4p7ieqpNV8YgJTumHTQdpvbLSjDbf5F5Rv67iyT5meGanJRg/UGpy
X-Google-Smtp-Source: AGHT+IFem7AKTlrZNsCjCaoU1OPrjcty6AXyb5TE5ncIv0OBYEUj9H4ORU5Tw+Q3tv0Kge9QpMJknPvIgtZgno1e3rI=
X-Received: by 2002:a17:902:ea0e:b0:295:73f:90d0 with SMTP id
 d9443c01a7336-2951a526babmr24858695ad.50.1761878067240; Thu, 30 Oct 2025
 19:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-7-eperezma@redhat.com>
In-Reply-To: <20251030100025.95113-7-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 31 Oct 2025 10:34:16 +0800
X-Gm-Features: AWmQ_bmC3YOueNDW6iNYcPJZNW_BKgIBT-LE7SSvpdq3D_IQY_Fe2LpzgVsS--g
Message-ID: <CACycT3tPTW+QChEdAKw+ChP7weZvRTFZJ7-t=HcHs6M78ESpgg@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] vduse: bump version number
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
> Finalize the series by advertising VDUSE API v1 support to userspace.
>
> Now that all required infrastructure for v1 (ASIDs, VQ groups,
> update_iotlb_v2) is in place, VDUSE devices can opt in to the new
> features.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

