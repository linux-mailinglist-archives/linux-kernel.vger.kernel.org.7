Return-Path: <linux-kernel+bounces-799632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC7BB42E56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963CD5E77C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A9C14B977;
	Thu,  4 Sep 2025 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbujJXk7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7214A9B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756946836; cv=none; b=YK9Nosys7PMTReePh1uvqazvlobnTCcecGVjczHIZCh1YdOTPjeMtv3gMNsma836psH/MwSW/+actok8OFip9tvb+JyXMjwCp1A3j6z+4znxVdz7xgFkOSwt3n06+HsyiRjQiC8oSceYPysW1xXVy8JnLzgykbIuTbHy0AWcY4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756946836; c=relaxed/simple;
	bh=fgtAxIt0auoxLZHGqJqmkLBpAc93q8HByfWt9LLtHlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d91Xqssw2cLzTqNywNSIMjC9BxzpyO4EQMXSpk0QaStSrk2Yu9ylV67Zs374bxgKv/wNwCVeDUNA8ZtxDPnzU1LYlBgi/yp2Zg1tQha5+TIkhNxXFAArSYzC8TZ0xvdPrxrWEXgotfXrfQrmUPFa+6/aihibfQ802rRC6lKDk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbujJXk7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756946833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rBTWZqYxMCbwIRVUHkkykppHi5qw7KCSrBOdLy9bbQ=;
	b=IbujJXk7H43ADZD+V6ui1NgZsX+40PFbBOBpZWGGLeeQ35qJO1/5peWP4jQqh6HsUcB2Vg
	KXqOd4+IR2iXbDH1AcCJCI86ChRYqeR0eSMgsZLqwGEQYPJrnFHDoQRHyKUHf/rbyNMJqF
	nNt+FJAqeQlyI/SkC0gFLdf3+ZqDowM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-zIQUHdfzOpexuhy3YHDizw-1; Wed, 03 Sep 2025 20:47:11 -0400
X-MC-Unique: zIQUHdfzOpexuhy3YHDizw-1
X-Mimecast-MFC-AGG-ID: zIQUHdfzOpexuhy3YHDizw_1756946830
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4f86568434so304294a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756946830; x=1757551630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rBTWZqYxMCbwIRVUHkkykppHi5qw7KCSrBOdLy9bbQ=;
        b=kAFQC9cnzGisY5hHfHGlgjOR3wrq9QWUtR9Xf6yMiSjpcdEhQMWnYDBazvIjD2Wp+0
         3K1SmXUYelnQwAgJtp0UDvXU7qDvtfL/cR2R1wRi9tHJwLvJwTyTfDGB1bxZUk3WoePm
         igPVrpBf85bENb4/o6nxT4Z3KKD42sXSxbz5U39OzuVsPtQUimqNamiX4Zb/Dj97PdB8
         gBPumXoxV84Ce9jaQrQ7YqUE+N401EZe6lZfDi6Efw54F6+yXAZ2kIFFXZjZYKzuqnLA
         brkv32co4CebwZIIIxj1W6BAmVmuI2WCmHPVvKk7J7npKKheWX9d5bc4x+D+aOCxKvUt
         6mAg==
X-Forwarded-Encrypted: i=1; AJvYcCXJnAN3TeSBJ0vghxHYM0TYkDWKNgNFUzHW+JUMDXSFHkL6VHrgyvPwCfst2Z5ApTgXf/rXNwYaPX0kyCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoboAPwe1hANN/X6PoFHSMVXlSpGyMvXW4GsPspUJwbdbqiYYZ
	h3OQaY0U/n9vHjpIVHyjoLc9Zb1lAeO7hZznDh0NBlfJND8nHIyiJoOcbr1zjb4ZWCX+0tWxKu0
	xQQPbWlz5Dno0YH1j3bsHw0v+IhBROrllLAhavS6zDPnU5fPribdGmB8tl6+0m3WgqQ==
X-Gm-Gg: ASbGncvg5nPJN2UxdXJQfx5D4Xr1ggwuoNsPUlxO4P4REo1mg2i8LsLKYDPm+3y5ALp
	3vyFWPdTan/og+ktSPjFyKo1RzD7w6us7JaquOwIkc4T5N/CPvwWoStAYdZ1Ly5wHiUvQBUBdb9
	2yAO5JM83Mr61F3Jp9++Dv2W5WsQ5BEHqKOnRr5hiykkv1n3u4Lc/jrMaMceRBG1cQK+kQn4xSW
	QI04ZwQj8OZjZlfHBQ1xdRUmYMwVv0UjzUcSOTC8/mf9q/aGBhC09iLnNPUeaAfbL4A0kPkAnHI
	ScgEDBojuc+MjsCnnIOaGAS90r2c/aGCE6T0UYvzqLUpjgJEP/Dl4C5kez6XC5i/7JJtmbNgPj2
	69R4p
X-Received: by 2002:a05:6a20:c489:b0:246:2c:fc with SMTP id adf61e73a8af0-246002c0243mr7913952637.48.1756946830312;
        Wed, 03 Sep 2025 17:47:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIE1heha6NLiL0Mkgu6redBGDU2JQIw5VRfT/dIGF69ITV4kWD+34/z44Af0YiNh4zlPvwtw==
X-Received: by 2002:a05:6a20:c489:b0:246:2c:fc with SMTP id adf61e73a8af0-246002c0243mr7913928637.48.1756946829873;
        Wed, 03 Sep 2025 17:47:09 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327e21d14a8sm17973206a91.2.2025.09.03.17.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 17:47:09 -0700 (PDT)
Message-ID: <2aa76e3c-1e97-46d8-a8b7-c13cbbf05e8b@redhat.com>
Date: Thu, 4 Sep 2025 10:46:59 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/43] arm64: Support for Arm CCA in KVM
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve <vannapurve@google.com>
References: <20250820145606.180644-1-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250820145606.180644-1-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/21/25 12:55 AM, Steven Price wrote:
> This series adds support for running protected VMs using KVM under the
> Arm Confidential Compute Architecture (CCA).
> 
> The related guest support was merged for v6.14-rc1 so you no longer need
> that separately.
> 
> There are a few changes since v9, many thanks for the review
> comments. The highlights are below, and individual patches have a changelog.
> 
>   * Fix a potential issue where the host was walking the stage 2 page tables on
>     realm destruction. If the RMM didn't zero when undelegated (which it isn't
>     required to) then the kernel would attempt to work the junk values and crash.
> 
>   * Avoid RCU stall warnings by correctly settign may_block in
>     kvm_free_stage2_pgd().
> 
>   * Rebased onto v6.17-rc1.
> 
> Things to note:
> 
>   * The magic numbers for capabilities and ioctls have been updated. So
>     you'll need to update your VMM. See below for the updated kvmtool branch.
> 
>   * This series doesn't attempt to integrate with the guest-memfd changes that
>     are being discussed (see below).
> 
>   * Vishal raised an important question about what to do in the case of
>     undelegate failures (also see below).
> 

[...]

I tried to boot a guest using the following combinations, nothing obvious went to
wrong except several long existing issues (described below). So feel free to add:

Tested-by: Gavin Shan <gshan@redhat.com>

Combination
===========
host.tf-a        https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git      (v2.13-rc0)
host.tf-rmm      https://git.codelinaro.org/linaro/dcap/rmm                       (cca/v8)
host.edk2        git@github.com:tianocore/edk2.git                                (edk2-stable202411)
host.kernel      git@github.com:gwshan/linux.git                                  (cca/host-v10) (this series)
host.qemu        https://git.qemu.org/git/qemu.git                                (stable-9.2)
host.buildroot   https://github.com/buildroot/buildroot                           (master)
guest.qemu       https://git.codelinaro.org/linaro/dcap/qemu.git                  (cca/latest) (with linux-headers sync'ed)
guest.kvmtool    https://gitlab.arm.com/linux-arm/kvmtool-cca                     (cca/latest)
guest.edk2       https://git.codelinaro.org/linaro/dcap/edk2                      (cca/latest)
guest.kernel     git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (v6.17.rc3)
guest.buildroot  https://github.com/buildroot/buildroot                           (master)

Script to start the host
========================
gshan@nvidia-grace-hopper-01:~/sandbox/qemu/host$ cat start.sh
#!/bin/sh
HOST_PATH=/home/gshan/sandbox/qemu/host
GUEST_PATH=/home/gshan/sandbox/qemu/guest
IF_UP_SCRIPT=/etc/qemu-ifup-gshan
IF_DOWN_SCRIPT=/etc/qemu-ifdown-gshan

sudo ${HOST_PATH}/qemu/build/qemu-system-aarch64                        \
-M virt,virtualization=on,secure=on,gic-version=3,acpi=off              \
-cpu max,x-rme=on -m 3G -smp 8                                          \
-serial mon:stdio -monitor none -nographic -nodefaults                  \
-bios ${HOST_PATH}/tf-a/flash.bin                                       \
-kernel ${HOST_PATH}/linux/arch/arm64/boot/Image                        \
-initrd ${HOST_PATH}/buildroot/output/images/rootfs.cpio.xz             \
-device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                   \
-device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                   \
-device pcie-root-port,bus=pcie.0,chassis=3,id=pcie.3                   \
-device pcie-root-port,bus=pcie.0,chassis=4,id=pcie.4                   \
-device virtio-9p-device,fsdev=shr0,mount_tag=shr0                      \
-fsdev local,security_model=none,path=${GUEST_PATH},id=shr0             \
-netdev tap,id=tap1,script=${IF_UP_SCRIPT},downscript=${IF_DOWN_SCRIPT} \
-device virtio-net-pci,bus=pcie.2,netdev=tap1,mac=b8:3f:d2:1d:3e:f1

Script to start the guest
=========================
gshan@nvidia-grace-hopper-01:~/sandbox/qemu/guest$ cat start_full.sh
#!/bin/sh
key="VGhlIHJlYWxtIGd1ZXN0IHBlcnNvbmFsaXphdGlvbiBrZXkgaW4gZm9ybWF0IG9mIGJhc2U2NCAgICAgICAgIA=="
IF_UP_SCRIPT=/etc/qemu-ifup
IF_DOWN_SCRIPT=/etc/qemu-ifdown

qemu-system-aarch64 -enable-kvm \
-object rme-guest,id=rme0,measurement-algorithm=sha512,personalization-value=${key} \
-M virt,gic-version=3,confidential-guest-support=rme0                               \
-cpu host -smp 4 -m 2G -boot c                                                      \
-serial mon:stdio -monitor none -nographic -nodefaults                              \
-bios /mnt/edk2/Build/ArmVirtQemu-AARCH64/RELEASE_GCC5/FV/QEMU_EFI.fd               \
-device pcie-root-port,bus=pcie.0,chassis=1,id=pcie.1                               \
-device pcie-root-port,bus=pcie.0,chassis=2,id=pcie.2                               \
-drive file=/mnt/rhel10.qcow2,if=none,id=drive0                                     \
-device virtio-blk-pci,id=virtblk0,bus=pcie.1,drive=drive0,num-queues=4             \
-netdev tap,id=tap0,script=${IF_UP_SCRIPT},downscript=${IF_DOWN_SCRIPT}             \
-device virtio-net-pci,bus=pcie.2,netdev=tap0,mac=b8:3f:d2:1d:3e:f9

Issues
======
1. virtio-iommu isn't supported by QEMU. The guest kernel becomes stuck at IOMMU
probing time where the endpoint's capabilities is queried by sending request over
virtio device's vring and the response is expected to be fed by QEMU. The request
can't be seen by QEMU due to the wrong IOMMU address translation used in QEMU as
virtio-iommu provides a different IOMMU address translation operations to override
the platform one, leading the DMA address (in the shared space) can't be properly
recognized. The information has been shared to Jean.

2. 'reboot' command doesn't work in the guest. QEMU complains some registers aren't
accessible from QEMU. I didn't sorted out a workaround for this.

3. HMP command 'dump-guest-memory' causes QEMU to exit abnormally. The cause is the
realm is reconfigured when the VM is resumed after the guest memory is dumped. The
reconfiguration is rejected by the host, leading QEMU's abnormal exit. The fix would
be to avoid the reconfiguration on the realm. The issue was originally reported by
Fujitsu and all the information has been shared to Fujitsu.

4. In QEMU, the CPU property 'kvm-no-adjvtime' can't be set to off. Otherwise, QEMU
tries to access the timer registers, which have been hidden by the host. So we need
to take the parameter (for QEMU) to by pass it: "-cpu host,kvm-no-adjvtime=on".

5. I didn't try virtio-mem and memory balloon, which isn't expected to work, especially
when the guest memory is hot added or hot removed.

Thanks,
Gavin



