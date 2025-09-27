Return-Path: <linux-kernel+bounces-835000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5804EBA600E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 15:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10D31B23A40
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371771E3DF2;
	Sat, 27 Sep 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH10xkyc"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3952D1DE3B7
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981566; cv=none; b=WaFv+PUv0OxuRBpZ2r7Tiz7/CrhZTEQZ7v5ui+d9k/HHdGDvw+XpEPAN6TaIgv72vKx+he4IkOs0IfKYmsRPSDvVWlEVbpGOvVUjiQj8U4F0OSyx8tO6ncQgzMcG27z3bRwNLWvYO2UJaSA21pd4Lv19UZGy6p19/LFxA7D4j24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981566; c=relaxed/simple;
	bh=fcHiWyXrlFKXvBYGJ+K3ybehrxbtVs47y8UOfxcApoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fG0nFMxqShdr8yZtdETgrScSaq/GfS/+vWwrC5tPCvaix8Xcq22fxr9K64FMLc5KZKZgENNMmm9h7HNilypPcTtGokTr9cepbYFC6qc87MboxBp+Ra7iqYqTf+f9eK6gA3g75Lsg5wKRefR+/Y4yimMLWZj1nSnA+EKGWgk0r9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nH10xkyc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27edcbcd158so28900435ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758981564; x=1759586364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ2zurBZlXyqU6xN/6EaGXAHpVHgluSazTPc6JBBq6Y=;
        b=nH10xkyc9cde1tERg2coU9NQpiXEEfU2/xui9bdVZYz8Vr/B1PDFeYxMwkO52MJRPj
         9blcA1NKKi6o0CaAWsP0DJKelAGW/4osgS5A5kKXVKGRIF9fvHziQ8Fck9cSGr90Njda
         lCT3Qsq3/Is9L5Q2jsGEHb8koSU2akPc5xiwTjhMpUEadqxcG6l9w7Ia5iF9lFcKQMte
         hd8B1xQLTgOFpYDqv4iS/bpgN0srNSvca0XkIvc632WrXrszQysFWS8Dgp7v4sc+GPxx
         CiWVtOP3zzqsCSWLg4eskp46DRmgW3w8OsRHRJzHml8XUNrOEurmnPdKEdvBeBnAXk4q
         g+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758981564; x=1759586364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ2zurBZlXyqU6xN/6EaGXAHpVHgluSazTPc6JBBq6Y=;
        b=gwmTtCvmrN9s5+4CQpw2KJgxDzkIc6fo095McjHqP390dxNm6hZaQYiM9zWB1lqeqY
         sokTR+a1OFhVfGzOQHM+YI97ZQnSrEP95ZvckxqelaRhoCsVKwXJvh0Qmnez1IXOQ4j6
         DTQFzerDsOquP8MAI4EisR3pX/U3QtMep0wkPu1UkGrszJiN1ZDFolrIRMZlLSrrd1FZ
         1xwnyaHzUGACsnJIE7wEoYhudVR93mXyNxdb2U30Lc4nHtdqQUqSZ7PS7O9gOLj0rhNy
         HptgYwuVFRR+flYlPz+1ijg+MUUGNDgtNWggSxJbuuir1jgUaA+ezL5Q/nUQJ0lhnoZR
         0j+A==
X-Forwarded-Encrypted: i=1; AJvYcCW5zK6cj7wtqW92N6VRyHwZDW9Zp23IjWPLE76RwaT1gsoeaZezLp20SDOayPd9zPruWKAY+VxUjzlA84w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgcZRj4lLqfFbYh/cjdb6N50+/9Zlgdd7u6dvoMluCrsX+YglB
	DTDGXwqc3t10HdykI6TgWjhZ+/ooCHlBHeVKzFhQlB3ztlpZWG5hpuK9
X-Gm-Gg: ASbGncv9cbAtFzEK0OaGCVXY7+WbFksMZzlGPsLDirBMReOVNOkbOht5IuWq/tayJZ+
	H72Kk2WrOIjt95qqcksuJol/+bn/839AWj6ZmKT5QGnAuMzV/dtr6uLVidx/GhZL50OyjdNnQSU
	VruSSpntIv/eHZ0snbviwvxJUdGLbu8E8jbMx1jk7zbB4vTwQvqoS2UX59Jr79FlWDW0fOV58qd
	CnVKUmqSPnyEggxkJFq0P8SLfMAWpO84yEpIr8aYrp6mRdIgUu4I6s5GaY5+Ka98/fj7uo6uP1i
	aPdMaOhTNXs/mZMOMmd8M6YWyyUXGVvXlVZRVL7vVyRMCQxVWFUr6VJ+Zd26LqoAFGcse3OTEg8
	HjOnkJsQ6XBHqUT8XgmiPFUxx
X-Google-Smtp-Source: AGHT+IEf78Oq9CDF3Gdqzh+zztJ/1K0sMtW4DnsPMDn/dIyyhBV9SYuiQfoD+F6FHky70q2kK7m2SA==
X-Received: by 2002:a17:903:2f8c:b0:27e:c27f:b834 with SMTP id d9443c01a7336-27ed4a6dc52mr119233195ad.56.1758981564487;
        Sat, 27 Sep 2025 06:59:24 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:1f0b:281e::3ff:4e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cf181sm82444095ad.28.2025.09.27.06.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 06:59:24 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@sifive.com>,
	Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 04/11] dt-bindings: timer: Add Anlogic DR1V90 CLINT
Date: Sat, 27 Sep 2025 21:59:12 +0800
Message-Id: <20250927135912.3327-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922-dr1v90-basic-dt-v2-4-64d28500cb37@pigmoral.tech>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech> <20250922-dr1v90-basic-dt-v2-4-64d28500cb37@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Junhui,
On Mon, 22 Sep 2025 20:46:34 +0800, Junhui Liu <junhui.liu@pigmoral.tech> wrote:
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -29,6 +29,7 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - anlogic,dr1v90-clint    # Anlogic DR1V90

UX900 uses the ACLINT with SSWI. Please use the new ACLINT binding.

Link: https://www.nucleisys.com/upload/files/doc/Nuclei_RISC-V_ISA_Spec.pdf

>                - canaan,k210-clint       # Canaan Kendryte K210
>                - eswin,eic7700-clint     # ESWIN EIC7700
>                - sifive,fu540-c000-clint # SiFive FU540
> 
> -- 
> 2.51.0

Regards,
Qingfang

