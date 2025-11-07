Return-Path: <linux-kernel+bounces-889613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95250C3E0CE
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A7F188E30E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDC93054FA;
	Fri,  7 Nov 2025 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtLhWvLj"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EDC2FB0A7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476605; cv=none; b=ZxPZqD03TiPsHb9Z3vXFmVXd9k0Vf+5v823FKiSlglxEv7JI/JQ8TtzPJdQUA1+P936HCgJgU7eBxtfn1avhOlpBRkIBmOXmu/LBny6fzEpGPtDqRbrtdj3gUMZcJoM9WhblO4bwvl8eO10NmHtv5Qe2CfL1pzr63bDxHmu4nTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476605; c=relaxed/simple;
	bh=GxjWMLryYjjKJpr6TT3LeDbeqAWdzd/wbLS6W72CbIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dm0eklxXIVYnEKIcb61fw/aRhsCVGxc4KEXUYVizOqNsr2OVJDSIEvKiTJIFFgW8nsSH5esJ+PVKHm+b7Q58CSCrhgxoEMt9VCnrTYtz7r+tbJl29uSk8yLWFwuIjxad1OTJzWFyvLZAULzJW5vEUwpkk33TMozOLoXlUpjtFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtLhWvLj; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so181699a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476602; x=1763081402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DCFKi0aY+3dE4R9e8oh4CcU6zhkT3ckh+srhUdXmfc=;
        b=BtLhWvLjh5egr8867jTIYFHKmFh8IGhbzvAGpiDirzMN0iBfyyhq68ULn/qBkfl4ys
         q+Tnq+nEo4jBLfXJQ/2CgThpT8vsularfbuN+Ig4iN2tGbEYl3myOBvlfFA0Mxh5qPoG
         7eZ3EHc8JCQLGim33EqOhpB/8NPFZTXVyxWqrkGDcCfTDciFHDxrZaVMrfLTy2GbQ722
         Sd3VbK5Npl7PfAvWgDV9GZ1UWNPLkfHZ0d1yJVEuE74+IywQN34iD9j1fFLMWM0Cijgn
         mjd+pE7jqZ9FLXp7ttpR68uXzaqp7eRYtbJZvHfQpQdPM0Og/ZYwFToa+6odyxfw67Sd
         fTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476602; x=1763081402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9DCFKi0aY+3dE4R9e8oh4CcU6zhkT3ckh+srhUdXmfc=;
        b=iZTYSMKGzm2ljbk4qLZGezGdiiU/lwqnqVTMQwAQj4ZpQIShJaMoZeia6/mjSgxkvj
         SwjLp9O86L6mghMyGgto4Kwu8TOe7cq4MCts13lnfUDjnGkjOesIG6ysGY1zXST+SqQx
         B32Y9qMcYU0nqbjZYHiCSXR6w9o+UFYDoOt3v1U9ggG2L+zwEc/5oQglrdzsYS4qHpgq
         neNWuBjNP+qhYsCy+Rv9GAgblOdYmV4Enni+YHVFZtrGOUpQZnyufQOXWP7LEReAQ4gk
         J/e3wPeQWSAJG3egttQOx4viZ9jkBfZ5ArNtBl7xa7UiwVgyplGNW3ugZWiWFtZat/4Y
         ZS4w==
X-Forwarded-Encrypted: i=1; AJvYcCUXOoqHus3/6noiKNRANJyWDEBAWfkHYoSBOFNpk2pV6HTnTeeWbGPd7fPoQBAuoj3EUz9Xhy3HPG4F1jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQCgqsmg+WraecH7i+ZtEH5n30hkQH52Tixx0wxYDkVdqm6nYp
	/66z3ZPxrphzdOIK50XOQ6xh6eOPYv5TQ1BVUB1WcdizCWH+YfaQ8HO1
X-Gm-Gg: ASbGnctZ6GkKgQM5QWyD+yoyr5bMtOXO5uFsAZ1tOWnzs001B3Z8sRgdqk3Eh89Q01z
	GmTwxgJn+djCKA12+9pC1LWT/Krkg+ky6O+e+shE5YtWzfSYld2FhFnLaa4nTz4Nicvgm4dS31S
	fdQycVx6lZ0W2EJ9JqwZNva404t//56U5TdtsDdaQq5EfxzeTtK/qKchZAYGZQkH/md2GQKmDRN
	0M7nmfh6i069obAZLgrC7eLk5CYlJoOqENZD6VFKTmEfgRUoXwgqB1OMPqYC9kF9OTq/0VdOOBO
	mr6M11KT3WAHFIo4/SBaPi/SByXnAp1DA5T+13iZZKd8FmvtS9eAZQomFAQ5fMKrKk8C9s0zIce
	mVYrmq4YjgDNW6JMkBcBbD6MWFGpLi0FnQM9bwEVxIaZGp/Q/xGeXbfnZnculdvgQ92Gvr5oL
X-Google-Smtp-Source: AGHT+IGEV5/i8frm9hdbKMaepp45D3BIIaGPeZxpCw61DZpaDradXH7/QyynY840Xwr3dtOtnTjxPg==
X-Received: by 2002:a17:903:943:b0:295:82d0:9ba2 with SMTP id d9443c01a7336-297c0389dd7mr18651925ad.1.1762476601515;
        Thu, 06 Nov 2025 16:50:01 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccec04sm40921705ad.102.2025.11.06.16.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:50:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:54 -0800
Subject: [PATCH net-next v3 10/11] selftests/vsock: add vsock_loopback
 module loading
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-10-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test so that vmtest.sh
can be used for kernels built with loopback as a module.

This is not technically a fix as kselftest expects loopback to be
built-in already (defined in selftests/vsock/config). This is useful
only for using vmtest.sh outside of kselftest.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a5c33b475a39..cde048bd7fe6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -463,6 +463,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3


