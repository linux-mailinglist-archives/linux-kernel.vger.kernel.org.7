Return-Path: <linux-kernel+bounces-887738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640C6C38FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5771C189A22F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75EE2D2497;
	Thu,  6 Nov 2025 03:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="lDgfoTcG"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB62C3261
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 03:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399856; cv=none; b=seYuYeT3w6+D7XSJk1Jv4/zV4L5GyLEei1XU74RUHJUDGPvhmsGUoTiTedQVFMw7SimJncziYyDLEJgXhYPdwcSFfZRzqpJrnAUTISIdln7gMhM1V5sVCA6V/oWjIoAviMg9YdReyX/zM7br3X7cFyzhp9WjE2mMZpQWKtPJIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399856; c=relaxed/simple;
	bh=d1g8ydiJWl6KjcwImL2cCAUc1WKS01GAFRGdz38s5AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKwtmuSio6bktY+JFMD1tZN4bBjj5FdT1WJUNlFgiMoctBRfTssfukWZIWgVTS+snurgeGLtMK1nBvpniLos7g/gejIIl5y6J0Ykez4LMyqF+VeIGzDVdYwKicjE63ZM6H2Y3ZEKKee4YDoyonMxV2ETLuPQVqsJTmdNKy14GoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=lDgfoTcG; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so1298382a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 19:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762399853; x=1763004653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNM1MgLcHWEpaTBbCLnta7C99WnzqNME1CrFjvq8FrU=;
        b=lDgfoTcGj+DI3x4QL+F/F+mCkXDK6aD1utwISK150dMHhvCoxgDFxIP52lETbAaZ3l
         /tArvEZU04eed1uMSAgSABjGk++QK/ZXb2I7dMXwVWsqxONmnL6hd9k7JTWzVnSrvTrE
         GLhPTMA9z8YxpqFCHa1rdXMvxUzfv05AezYs3WrT1LX69C7tdpquEZiRLg1BCz0nmbOf
         eydXarVUIMqXt5E5OEolz84REpzJplcoS+bFPahsNL8dhljny+//u+aIkjv7VgzxGdpm
         57DifDs5F5zSotvlC2MbCkKA02Igxpvhiy33RVHv2/CzIz9X1ov8pnekL8wbtax3YvBN
         hNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762399853; x=1763004653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RNM1MgLcHWEpaTBbCLnta7C99WnzqNME1CrFjvq8FrU=;
        b=w4w1/58K5+fMHpjL9uCYYMQHYa/AHXTcWxNu1HEooKThy3v0mjLYw02bBx7nsa07AN
         EZ/tkrGxiFaB3JaqC8aP+XBpadvW0XMmBO/XliFTzWVDBM8lBaCfCxaeLGbyQUyumm6T
         ffLlBk4hn6BZwvbFl6t5TVaR382+YIw1kiSgORFzEfE3jwI6BtnmalTkgjp0qjAmPG2B
         pCjGsh2QgvvZLrALbEXHUrZtRg4PfzXpwf2lxEIPkrL3Fod4UH9VUlpj7WLJILxD/4B2
         5Djb6HaN6M6cLr+wtDU+FhXqpoCGgpyr5gWsPyjwB8yJhR9EcQ8uDu3/Nv3V9p2G/Mqm
         kYHw==
X-Forwarded-Encrypted: i=1; AJvYcCWdo5HcCPkRH3UmJ3MJbuJLJ4E5rvahkWiMQT/OdNUI+PXQd103sZ5OZkfDBl36qjQ4NLwUWz3UwRD1Pts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw248detNME37qMit9xQ5IgKIuQipnQxlYze7il666wt1/eQok4
	WQrWr/vuE75VKfJPzvtCWxAZWRQwNMUG/GhaMbnHPwm6qxfgKPLs+WLIh6qqQHGfpX0=
X-Gm-Gg: ASbGncuSEn3luKumXIKaDVRfs6bGFeD+hUDxji+k4SoEc81zdAuF+OdmzAFps9NTd0T
	KYkouHMfeorlwnemWI9LY8mkVdpOXm4zbslmcjZbWZeP8zrZJFs2EZbi4rEPR6QKdYFTSfRXuBd
	T/POLXOv5PpK4/HT4FEx2txPDAOS4W63VblHQygNLhHgz+NanoMXlUXMMDoI76deNAVsKSg/pkY
	zLuYyk7rddEMUkXspRTrpvS5d3kemxx94ZBxbifjdPVjkcawlqgqX9OOnb8T1SfPR4QO9N7LhJE
	k0FKRvZgopWszqztByVLgg08vxebFnTga3bVofny98muQ5o5ruLB+/RAMFr691eP3n89vEed3mN
	9lNO0LtWR3XhmIsG8mfw0/8plfmjnbLpzdX7BznzzgQpP2P9jXBoh9ipv2cWtd0JXhkfmwwr0xt
	8N5aJ1RPBAvdhBxg==
X-Google-Smtp-Source: AGHT+IGs3l7sTKPjK4BxzxoB8dGFRJGxiJ/b+4pm0w/YxL5LnyVyRhr4bJJbufT0LQgr9Sm10ohs0A==
X-Received: by 2002:a17:90b:3d4c:b0:341:88c5:d58 with SMTP id 98e67ed59e1d1-341cd150316mr2074007a91.13.1762399853479;
        Wed, 05 Nov 2025 19:30:53 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a69b698asm4663896a91.21.2025.11.05.19.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 19:30:52 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: shakeel.butt@linux.dev
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	hannes@cmpxchg.org,
	inwardvessel@gmail.com,
	jack@suse.cz,
	joel.granados@kernel.org,
	kyle.meyer@hpe.com,
	lance.yang@linux.dev,
	laoar.shao@gmail.com,
	leon.huangfu@shopee.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mclapinski@google.com,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	yosry.ahmed@linux.dev
Subject: Re: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
Date: Thu,  6 Nov 2025 11:30:45 +0800
Message-ID: <20251106033045.41607-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <6kh6hle2xp75hrtikasequ7qvfyginz7pyttltx6pkli26iir5@oqjmglatjg22>
References: <6kh6hle2xp75hrtikasequ7qvfyginz7pyttltx6pkli26iir5@oqjmglatjg22>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 6, 2025 at 9:19 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>
> +Yosry, JP
>
> On Wed, Nov 05, 2025 at 03:49:16PM +0800, Leon Huang Fu wrote:
> > On high-core count systems, memory cgroup statistics can become stale
> > due to per-CPU caching and deferred aggregation. Monitoring tools and
> > management applications sometimes need guaranteed up-to-date statistics
> > at specific points in time to make accurate decisions.
>
> Can you explain a bit more on your environment where you are seeing
> stale stats? More specifically, how often the management applications
> are reading the memcg stats and if these applications are reading memcg
> stats for each nodes of the cgroup tree.
>
> We force flush all the memcg stats at root level every 2 seconds but it
> seems like that is not enough for your case. I am fine with an explicit
> way for users to flush the memcg stats. In that way only users who want
> to has to pay for the flush cost.
>

Thanks for the feedback. I encountered this issue while running the LTP
memcontrol02 test case [1] on a 256-core server with the 6.6.y kernel on XFS,
where it consistently failed.

I was aware that Yosry had improved the memory statistics refresh mechanism
in "mm: memcg: subtree stats flushing and thresholds" [2], so I attempted to
backport that patchset to 6.6.y [3]. However, even on the 6.15.0-061500-generic
kernel with those improvements, the test still fails intermittently on XFS.

I've created a simplified reproducer that mirrors the LTP test behavior. The
test allocates 50 MiB of page cache and then verifies that memory.current and
memory.stat's "file" field are approximately equal (within 5% tolerance).

The failure pattern looks like:

  After alloc: memory.current=52690944, memory.stat.file=48496640, size=52428800
  Checks: current>=size=OK, file>0=OK, current~=file(5%)=FAIL

Here's the reproducer code and test script (attached below for reference).

To reproduce on XFS:
  sudo ./run.sh --xfs
  for i in {1..100}; do sudo ./run.sh --run; echo "==="; sleep 0.1; done
  sudo ./run.sh --cleanup

The test fails sporadically, typically a few times out of 100 runs, confirming
that the improved flush isn't sufficient for this workload pattern.

I agree that providing an explicit flush mechanism allows users who need
guaranteed accuracy to pay the cost only when necessary, rather than imposing
more aggressive global flushing on all users.

Thanks,
Leon

---

Links:
[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/controllers/memcg/memcontrol02.c
[2] https://lore.kernel.org/all/20231129032154.3710765-1-yosryahmed@google.com/
[3] https://lore.kernel.org/linux-mm/20251103075135.20254-1-leon.huangfu@shopee.com/

---

Reproducer code (pagecache_50m_demo.c):

#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

static int write_str(const char *path, const char *s) {
    int fd = open(path, O_WRONLY | O_CLOEXEC);
    if (fd < 0) { perror(path); return -1; }
    ssize_t w = write(fd, s, strlen(s));
    if (w != (ssize_t)strlen(s)) { perror("write"); close(fd); return -1; }
    close(fd);
    return 0;
}

static long read_long_file(const char *path) {
    FILE *f = fopen(path, "re");
    if (!f) { perror(path); return -1; }
    long v = -1;
    if (fscanf(f, "%ld", &v) != 1) v = -1;
    fclose(f);
    return v;
}

static long read_stat_field_bytes(const char *path, const char *key) {
    FILE *f = fopen(path, "re");
    if (!f) { perror(path); return -1; }
    char *line = NULL; size_t n = 0; long val = -1;
    while (getline(&line, &n, f) > 0) {
        if (strncmp(line, key, strlen(key)) == 0) {
            char *p = line + strlen(key);
            while (*p == ' ' || *p == '\t') p++;
            val = strtoll(p, NULL, 10);
            break;
        }
    }
    free(line);
    fclose(f);
    return val;
}

static int make_memcg_child(char *cg, size_t cg_sz) {
    const char *root = "/sys/fs/cgroup";
    int n = snprintf(cg, cg_sz, "%s/memcg_demo_%d", root, getpid());
    if (n < 0 || n >= (int)cg_sz) {
        fprintf(stderr, "cg path too long\n"); return -1;
    }
    if (mkdir(cg, 0755) && errno != EEXIST) { perror("mkdir cg"); return -1; }

    // best-effort enable memory controller on parent
    char parent[PATH_MAX];
    strncpy(parent, cg, sizeof(parent));
    parent[sizeof(parent)-1] = '\0';
    char *s = strrchr(parent, '/');
    if (s && s != parent) {
        *s = '\0';
        char stc[PATH_MAX];
        n = snprintf(stc, sizeof(stc), "%s/cgroup.subtree_control", parent);
        if (n >= 0 && n < (int)sizeof(stc)) (void)write_str(stc, "+memory");
    }

    char procs[PATH_MAX];
    n = snprintf(procs, sizeof(procs), "%s/cgroup.procs", cg);
    if (n < 0 || n >= (int)sizeof(procs)) { fprintf(stderr, "path too long\n"); return -1; }
    char pidbuf[32]; snprintf(pidbuf, sizeof(pidbuf), "%d", getpid());
    if (write_str(procs, pidbuf) < 0) return -1;
    return 0;
}

/* Exact mirror of LTP alloc_pagecache() behavior */
static inline void alloc_pagecache_exact(const int fd, size_t size)
{
    char buf[BUFSIZ];
    size_t i;

    if (lseek(fd, 0, SEEK_END) == (off_t)-1) {
        perror("lseek"); exit(1);
    }
    for (i = 0; i < size; i += sizeof(buf)) {
        ssize_t w = write(fd, buf, sizeof(buf));
        if (w < 0) { perror("write"); exit(1); }
        if ((size_t)w != sizeof(buf)) { fprintf(stderr, "short write\n"); exit(1); }
    }
}

static bool approx_equal(long a, long b, double tol_frac) {
    long diff = labs(a - b);
    long lim = (long)((double)b * tol_frac);
    return diff <= lim;
}

int main(int argc, char **argv) {
    const char *mnt = (argc >= 2) ? argv[1] : ".";
    char cg[PATH_MAX];
    if (make_memcg_child(cg, sizeof(cg)) < 0) {
        fprintf(stderr, "Failed to setup memcg (need root? cgroup v2?)\n");
        return 1;
    }
    printf("Created cg %s\n", cg);

    char p_current[PATH_MAX], p_stat[PATH_MAX];
    int n = snprintf(p_current, sizeof(p_current), "%s/memory.current", cg);
    if (n < 0 || n >= (int)sizeof(p_current)) { fprintf(stderr, "path too long\n"); return 1; }
    n = snprintf(p_stat, sizeof(p_stat), "%s/memory.stat", cg);
    if (n < 0 || n >= (int)sizeof(p_stat)) { fprintf(stderr, "path too long\n"); return 1; }

    char filepath[PATH_MAX];
    n = snprintf(filepath, sizeof(filepath), "%s/tmpfile", mnt);
    if (n < 0 || n >= (int)sizeof(filepath)) { fprintf(stderr, "file path too long\n"); return 1; }

    int fd = open(filepath, O_RDWR | O_CREAT | O_TRUNC, 0600);
    if (fd < 0) { perror("open tmpfile"); return 1; }

    long current = read_long_file(p_current);
    printf("Created temp file: memory.current=%ld\n", current);

    const size_t size = 50UL * 1024 * 1024; // 50 MiB
    alloc_pagecache_exact(fd, size);

    // No fsyncs; small wait to reduce XFS timing flakiness
    //fsync(fd);
    //usleep(2200000);

    current = read_long_file(p_current);
    long file_bytes = read_stat_field_bytes(p_stat, "file");
    printf("After alloc: memory.current=%ld, memory.stat.file=%ld, size=%zu\n",
           current, file_bytes, size);

    bool ge_size = (current >= (long)size);
    bool file_pos = (file_bytes > 0);

    // Approximate LTP's values_close(..., file_to_all_error) with 5% tolerance
    double tol = 0.05;
    bool approx = approx_equal(current, file_bytes, tol);

    printf("Checks: current>=size=%s, file>0=%s, current~=file(%.0f%%)=%s\n",
           ge_size ? "OK" : "FAIL",
           file_pos ? "OK" : "FAIL",
           tol * 100,
           approx ? "OK" : "FAIL");

    close(fd);
    return (ge_size && file_pos && approx) ? 0 : 2;
}

Build: gcc -O2 -Wall pagecache_50m_demo.c -o pagecache_50m_demo

Test runner (run.sh):

#!/usr/bin/env bash
set -euo pipefail

# Config (overridable via env)
SIZE_MB="${SIZE_MB:-500}"
IMG="${IMG:-/var/tmp/pagecache_demo.img}"
MNT="${MNT:-/mnt/pagecache_demo}"
DEMO_BIN="${DEMO_BIN:-./pagecache_50m_demo}"
STATE="${STATE:-/var/tmp/pagecache_demo.state}" # stores LOOP + FS type

usage() {
  echo "Usage:"
  echo "  sudo $0 --ext4         Prepare ext4 loopback FS and mount it at \$MNT"
  echo "  sudo $0 --xfs          Prepare xfs  loopback FS and mount it at \$MNT"
  echo "  sudo $0 --btrfs        Prepare btrfs loopback FS and mount it at \$MNT"
  echo "  sudo $0 --tmpfs        Prepare tmpfs mount at \$MNT (no image/loop)"
  echo "  sudo $0 --run          Run demo on mounted \$MNT"
  echo "  sudo $0 --cleanup      Unmount and remove loop/image/state"
  echo
  echo "Env overrides:"
  echo "  SIZE_MB (default 256), IMG, MNT, DEMO_BIN, STATE"
}

need_root() {
  if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
    echo "Please run as root (sudo)"
    exit 1
  fi
}

have_cmd() { command -v "$1" > /dev/null 2>&1; }

save_state() {
  local loop="${1:-}" fstype="$2"
  printf 'LOOP=%q\nFSTYPE=%q\nIMG=%q\nMNT=%q\n' "$loop" "$fstype" "$IMG" "$MNT" > "$STATE"
}

load_state() {
  if [[ ! -f "$STATE" ]]; then
    echo "State not found: $STATE. Run --ext4/--xfs/--btrfs/--tmpfs first."
    exit 1
  fi
  # shellcheck disable=SC1090
  . "$STATE"
  : "${FSTYPE:?}" "${IMG:?}" "${MNT:?}"
  # LOOP may be empty for tmpfs
}

cleanup_mount() {
  set +e
  if mountpoint -q "$MNT"; then
    umount "$MNT" || umount -l "$MNT"
  fi
  if [[ -n "${LOOP:-}" ]] && [[ -b "${LOOP:-}" ]]; then
    losetup -d "$LOOP" 2> /dev/null || true
  else
    # Detach any loop using IMG as fallback
    if [[ -f "$IMG" ]]; then
      if losetup -j "$IMG" | grep -q .; then
        losetup -j "$IMG" | awk -F: '{print $1}' | xargs -r -n1 losetup -d
      fi
    fi
  fi
  rmdir "$MNT" 2> /dev/null || true
  set -e
}

cleanup_all() {
  echo "[*] Cleaning up..."
  if [[ -f "$STATE" ]]; then
    load_state || true
  fi
  cleanup_mount
  # For tmpfs there is no image; for others remove image
  if [[ "${FSTYPE:-}" != "tmpfs" ]]; then
    rm -f "$IMG"
  fi
  rm -f "$STATE"
  rmdir /sys/fs/cgroup/memcg_demo_* || true
  echo "[*] Done."
}

make_image() {
  echo "[*] Creating sparse image: $IMG (${SIZE_MB} MiB)"
  dd if=/dev/zero of="$IMG" bs=1M count=0 seek="$SIZE_MB" status=none
}

attach_loop() {
  # stdout returns loop device path only
  losetup -fP --show "$IMG"
}

ensure_loop_ready() {
  local dev="$1"
  if [[ -z "$dev" ]]; then
    echo "Failed to get loop device for $IMG"
    exit 1
  fi
  # udev settle
  for _ in {1..10}; do
    [[ -b "$dev" ]] && return 0
    sleep 0.1
  done
  echo "Loop device is not a block device: $dev"
  exit 1
}

mkfs_ext4() {
  have_cmd mkfs.ext4 || {
    echo "mkfs.ext4 not found"
    exit 1
  }
  echo "[*] Making ext4 on $1"
  mkfs.ext4 -F -q "$1"
}

mkfs_xfs() {
  have_cmd mkfs.xfs || {
    echo "mkfs.xfs not found (install xfsprogs)"
    exit 1
  }
  echo "[*] Making xfs on $1"
  mkfs.xfs -f -q "$1"
}

mkfs_btrfs() {
  have_cmd mkfs.btrfs || {
    echo "mkfs.btrfs not found (install btrfs-progs)"
    exit 1
  }
  echo "[*] Making btrfs on $1"
  mkfs.btrfs -f -q "$1"
}

mount_fs_dev() {
  mkdir -p "$MNT"
  echo "[*] Mounting $1 at $MNT"
  mount "$1" "$MNT"
  df -h "$MNT" || true
}

prepare_fs_loop() {
  need_root
  local fstype="$1" # ext4 | xfs | btrfs

  rm -f "$STATE"
  if mountpoint -q "$MNT" || losetup -j "$IMG" | grep -q . || [[ -f "$IMG" ]]; then
    echo "[*] Previous environment detected, cleaning first..."
    cleanup_all
  fi

  make_image
  local loop
  loop="$(attach_loop)"
  ensure_loop_ready "$loop"

  case "$fstype" in
    ext4) mkfs_ext4 "$loop" ;;
    xfs) mkfs_xfs "$loop" ;;
    btrfs) mkfs_btrfs "$loop" ;;
    *)
      echo "Unknown fs: $fstype"
      exit 1
      ;;
  esac

  mount_fs_dev "$loop"
  save_state "$loop" "$fstype"
  echo "[*] Prepared $fstype at $MNT (loop=$loop)"
}

prepare_tmpfs() {
  need_root
  rm -f "$STATE"
  if mountpoint -q "$MNT"; then
    echo "[*] Unmounting previous $MNT..."
    umount "$MNT" || umount -l "$MNT"
  fi
  mkdir -p "$MNT"
  echo "[*] Mounting tmpfs at $MNT (size=${SIZE_MB}m)"
  mount -t tmpfs -o "size=${SIZE_MB}m" tmpfs "$MNT"
  df -h "$MNT" || true
  save_state "" "tmpfs"
  echo "[*] Prepared tmpfs at $MNT"
}

run_demo() {
  need_root
  load_state
  if ! mountpoint -q "$MNT"; then
    echo "Mount point not mounted: $MNT. Did you run --$FSTYPE first?"
    exit 1
  fi
  if [[ ! -x "$DEMO_BIN" ]]; then
    echo "Demo binary not found or not executable: $DEMO_BIN"
    exit 1
  fi
  echo "[*] Running demo on $MNT: $DEMO_BIN $MNT"
  "$DEMO_BIN" "$MNT"
}

case "${1:-}" in
  --ext4) prepare_fs_loop ext4 ;;
  --xfs) prepare_fs_loop xfs ;;
  --btrfs) prepare_fs_loop btrfs ;;
  --tmpfs) prepare_tmpfs ;;
  --run) run_demo ;;
  --cleanup) cleanup_all ;;
  *)
    usage
    exit 1
    ;;
esac

