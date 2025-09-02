Return-Path: <linux-kernel+bounces-795728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0D1B3F723
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B03164DE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283CC2E7BCB;
	Tue,  2 Sep 2025 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hL7x22yy"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489C12E4279
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799774; cv=none; b=SrU4trlmfME29+q1l4aPnBgliw1ktZW0HkHal+YziNJtW0850tKKKXxzNRSnly0v/d3SlemSlbhpSucr9AiV6GH0BLFWy1m90TeiEGx1h5/OdQzszgdjMGdUjlzdQiwmnTrNEclrY9d8yU4pPTKXqo5x9H61tHjIegqDLn5bbfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799774; c=relaxed/simple;
	bh=qVMnMiEgPmLlzWR7EkQDGtRMIjHGnHGBM5Z3CxVS+cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tquil1/RIvxn2ri0F2RmLebg0fQyYZtxRVLIYbJwMYenDi+ko3Z9ej9OOR47smB6VX+ET3yVpwbOiN0cEXfSMINXlDyS3j0EVmdCLo1FB35Ms5slVn75fH4fldWmX4ATGvgQ09mNHLmGXrT7Net4Hz7miSx+jE4vwsshMUg/HiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hL7x22yy; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7722bcb989aso2691972b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756799772; x=1757404572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVMnMiEgPmLlzWR7EkQDGtRMIjHGnHGBM5Z3CxVS+cQ=;
        b=hL7x22yysV0qcV4JCwPfSw9IbqUgfMrktISuOZo+MDMV8RSPiVwHnyKOo6SNLdrNRO
         ifxm0j/O9cz1AbYJG0YN5Lrtry9drcSzwCSpYBzVMFSqi59Pqfvzp1wgqnDWKn222wiy
         QCEtrqnZSsGsvZVUIS6NXhqn+RN64PBZnaKMR+OJnpOO83UyFQEzxPe5dVDbhsuW7VAW
         nat3D+z/Xd3nhieOwHDWCIHLAnzWLF0Gi7fBQx+OL4mFKvdrnXfCjicSbvvPOX+aBkZE
         1yqU6I1gvGxOgwsfCxwAVFPg0bum5nXWakhrSi73mByqUoZmriV9Fn/dHncaWYvHC5AW
         epFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756799772; x=1757404572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVMnMiEgPmLlzWR7EkQDGtRMIjHGnHGBM5Z3CxVS+cQ=;
        b=O7YCsmAGK3amdTR++OMzNVg+VOqGwbf+DrEl0+ZAJILj2+uEdQQaJ7wr6AZ5mzaGrs
         pohQTHV4lvoAX3yB9xEC1EMtRBnJWP+0z+VD9OE4RlHspcJfqgauwaWz4nVgxDqIOivT
         pGxpHDwCZIqO1D4rUP04RrBW1xn3P2vMLk9YkFfNiVbjrwt+eT/OWpZd1nGKcnguYnhH
         lvtZ0aC+CkvV+lzbVVUBqQ+S7Q6rK4QchUgJdfsd/HUX9iFITWGV59I3opjS74QRGRF6
         nV4mKXiOxAqXOlKFeiOFIEFK+CTxgqEpoKGjTWesgLiTXudLLjDkXE0ISYOBk1vva+Dl
         QYbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+nLM8IrLHh0Bwi+MH/SoikJC9hzq2LrsUnFg39QaX8xoT4tAgD1sRK/bP9BlLvudqo6mNybpldh1xDgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPfe1/QfpoHzcoUf5DLlTf4XagepkbrE/beeTeBKCyZGnWlDhv
	im+WT/rU+uARxOBQgv6+OJPFrbigHu0Z4MVSsl/cHt4kCAAJQltl82sm
X-Gm-Gg: ASbGncvkeIZpog3sY4wNoxKCytoBedkn0mS9euubm9/T8E/BfoCxJa+a2NpyBT7Elei
	GZQU4kMmGmHjdvd28+EEaRLGTijugOCqUgYV3Zzw2BQKKllR0Nc/HIsAYW/UNST5TZX+ZkqIoPy
	LtY20BNvzZUgnd3VGvkut+JU4s4OccgfSqZmUuFmGa2b49ZalFxomMPUZCVvx/MVoP/gSuacChA
	T7QdIDz9vbmAlgioo80TSwDZsQHPSjLCVtfhRp/Tl3nSrO+SikodII6EMLDQIWSVQXopn6Ia2TK
	kDxGIS3vAoJ9/XfCz3YQaWOgI5crtbHEzGjByTgkJeZDJ6ZFSL/TgJNZO2XYDJE/Ms6dvZ8U8j9
	UIw/dy9Yt6EQImgBazuXo
X-Google-Smtp-Source: AGHT+IGaeGrQoCbO6non2oEEmBGYzms99/B40XuzKni/iGwIjNaXM+Ej60j/tzeSA6Y3egz8h3sh/w==
X-Received: by 2002:a05:6a00:3407:b0:772:48c5:c761 with SMTP id d2e1a72fcca58-77248c5e186mr8251990b3a.10.1756799772380;
        Tue, 02 Sep 2025 00:56:12 -0700 (PDT)
Received: from hygon.. ([106.120.127.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2d97acsm12649622b3a.41.2025.09.02.00.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:56:12 -0700 (PDT)
From: Duan Tingyin <tingyin.duan@gmail.com>
To: yu.c.chen@intel.com
Cc: aubrey.li@intel.com,
	bsegall@google.com,
	cyy@cyyself.name,
	dietmar.eggemann@arm.com,
	gautham.shenoy@amd.com,
	hdanton@sina.com,
	jianyong.wu@outlook.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	len.brown@intel.com,
	libo.chen@oracle.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sshegde@linux.ibm.com,
	tim.c.chen@linux.intel.com,
	tingyin.duan@gmail.com,
	vernhao@tencent.com,
	vincent.guittot@linaro.org,
	vineethr@linux.ibm.com,
	vschneid@redhat.com,
	yu.chen.surf@gmail.com,
	zhao1.liu@intel.com
Subject: Re: [RFC PATCH v4 25/28] sched: Skip cache aware scheduling if the process has many active threads
Date: Tue,  2 Sep 2025 15:56:01 +0800
Message-ID: <20250902075601.4601-1-tingyin.duan@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <d6a19a7d-e435-4a27-9725-b2fb802a52fd@intel.com>
References: <d6a19a7d-e435-4a27-9725-b2fb802a52fd@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

QWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRjaCwgdGhlIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gaGFz
IGJlZW4gc2lnbmlmaWNhbnRseSBpbXByb3ZlZC4gVGhhbmsgeW91ISAgCg==

